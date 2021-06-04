import 'dart:async';
import 'dart:convert';
import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/filter_model.dart';
import 'package:alonecall/app/data/model/maker_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/local_storage_repository.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/local_widget/profile_edit_dialog.dart';
import 'package:alonecall/app/utils/map_helper.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  /// Current index in [HomeView]
  int currentTab = 0;

  bool isSwitched = false;
  String textValue = '';

  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  ProfileModel model = ProfileModel();
  FilterModel filterModel = FilterModel();

  String city = '';
  String country = '';

  List<String> languageList = <String>[
    'English',
    'Hindi',
    'Bengali',
    'Marathi',
    'Telugu',
    'Tamil',
    'Gujarati',
    'Urdu',
    'Kannada',
    'Odia (Oriya)',
    'Malayalam',
    'Punjabi',
    'Bodo',
    'Dogri',
    'Kashmiri',
    'Konkani',
    'Maithili',
    'Manipuri',
    'Nepali',
    'Sanskrit',
    'Santali Language',
    'Sindhi',
    'Assamese'
  ];

  void addLanguageToList(String value) {
    filterModel.language.add(value);
    update();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
      textValue = 'You are visible on map now';
      update();
    } else {
      isSwitched = false;
      textValue = 'You are invisible on map now';
      update();
    }
  }

  final List<BottomNavigationBarItem> tab = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.money), label: ' '),
  ];

  void changeTab(int index) {
    currentTab = index;
    update();
  }

  String gender() {
    if (model.gender == 'Female') {
      return 'Male';
    }
    return 'Female';
  }

  int startAge = 0;
  int lastAge = 0;
  int initialDistance = 0;
  int lastDistance = 0;

  List<LatLng> latLong = <LatLng>[];

  @override
  void onInit() async {
    filterModel = await Repository().getFilterDetails();
    updateCurrentLocation();
    await Repository().latLongOfAllUser().then((value) {
      for (var i = 0; i < value.length; i++) {
        latLong.add(value[i].latLng);
      }
    });
    var data = await Repository().getProfile();
    var encoder = const JsonEncoder.withIndent('  ');
    var prettyPrint = encoder.convert(data);
    print(prettyPrint);
    await getCurrentLatLng();
    model = ProfileModel.fromJson(data);
    updateCoin();
    super.onInit();
  }

  int profileCurrentTab = 0;

  void updateCoin(){
    var coin = LocalRepository().getCoin();
    var audioCoin = LocalRepository().getCoin();

    if(coin > 0){
      Repository().updateCoin(model.coin - coin);
    }
    if(audioCoin > 0){
      Repository().updateAudioCoin(model.audioCoin - coin);
    }
  }

  void changeProfileTab(int index) {
    profileCurrentTab = index;
    update();
  }

  void updateAgeSlider(dynamic initAge, dynamic lastAge) {
    filterModel
      ..initAge = int.parse(initAge.toString().split('.')[0])
      ..lastAge = int.parse(lastAge.toString().split('.')[0]);
    update();
  }

  void updateDistanceSlider(dynamic initDistance, dynamic lastDistance) {
    filterModel
      ..initDistance = int.parse(initDistance.toString().split('.')[0])
      ..lastDistance = int.parse(lastDistance.toString().split('.')[0]);
    update();
  }

  void updateCurrentLocation()  {
    Utility.getCurrentLocation().then((value) {
      city = value.city;
      country = value.country;
      update();
    });
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  void showEditProfileDialog() {
    closeDialog();
    Get.bottomSheet<void>(
      ProfileEditDialog(
        model: model,
      ),
    );
  }

  double lat = 0.0;
  double long = 0.0;

  /// Get current lat long of the device.
  Future<void> getCurrentLatLng() async {
    var latLong = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat = latLong.latitude;
    long = latLong.longitude;
    Repository().distanceStream(lat, long);
    update();
    Utility.printDLog('Current lat,long $lat, $long');
  }

  final Completer<GoogleMapController> _mapController = Completer();

  /// Set of displayed markers and cluster markers on the map
  final Set<Marker> markers = {};

  /// Minimum zoom at which the markers will cluster
  final int minClusterZoom = 0;

  /// Maximum zoom at which the markers will cluster
  final int maxClusterZoom = 19;

  /// [Fluster] instance used to manage the clusters
  Fluster<MapMarker> clusterManager;

  /// Current map zoom. Initial zoom will be 15, street level
  double currentZoom = 15;

  /// Map loading flag
  bool isMapLoading = true;

  /// Markers loading flag
  bool areMarkersLoading = true;

  /// Url image used on normal markers
  final String markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';

  /// Color of the cluster circle
  final Color clusterColor = Colors.blue;

  /// Color of the cluster text
  final Color clusterTextColor = Colors.white;

  /// Called when the Google Map widget is created. Updates the map loading state
  /// and inits the markers.
  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    isMapLoading = false;
    update();
    _initMarkers();
  }

  /// Inits [Fluster] and all the markers with network images and updates the loading state.
  void _initMarkers() async {
    final markers = <MapMarker>[];

    for (var markerLocation in latLong) {
      final markerImage = await MapHelper.getMarkerImageFromUrl(markerImageUrl);

      markers.add(
        MapMarker(
          id: latLong.indexOf(markerLocation).toString(),
          position: markerLocation,
          icon: markerImage,
        ),
      );
    }

    clusterManager = await MapHelper.initClusterManager(
      markers,
      minClusterZoom,
      maxClusterZoom,
    );

    await updateMarkers();
  }

  /// Gets the markers and clusters to be displayed on the map for the current zoom level and
  /// updates state.
  Future<void> updateMarkers([double updatedZoom]) async {
    if (clusterManager == null || updatedZoom == currentZoom) return;

    if (updatedZoom != null) {
      currentZoom = updatedZoom;
    }

    areMarkersLoading = true;
    update();

    final updatedMarkers = await MapHelper.getClusterMarkers(
      clusterManager,
      currentZoom,
      clusterColor,
      clusterTextColor,
      80,
    );

    markers
      ..clear()
      ..addAll(updatedMarkers);

    areMarkersLoading = false;
    update();
  }

  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}
