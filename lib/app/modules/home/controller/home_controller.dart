import 'dart:async';
import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/maker_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/local_widget/profile_edit_dialog.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
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

  String city = '';
  String country = '';

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
        isSwitched = true;
        textValue = 'You are visible on map now';
        update();
    }
    else
    {
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
    const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ' '),
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
  List<LatLng> latLong = <LatLng> [ ];
  @override
  void onInit() async {
    updateCurrentLocation();
    await Repository().latLongOfAllUser().then((value){
      for(var i = 0; i < value.length; i++){
        latLong.add(value[i].latLng);
      }
    });
    var data = await Repository().getProfile();
    await getCurrentLatLng();
    print(data);
    model = ProfileModel.fromJson(data);
    super.onInit();
  }

  ///##########################################[ProfileView]###############################################################################
  int profileCurrentTab = 0;

  void changeProfileTab(int index) {
    profileCurrentTab = index;
    update();
  }

  void updateCurrentLocation(){
    Utility.getCurrentLocation().then((value){
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
    update();
    Utility.printDLog('Current lat,long $lat, $long');
  }
  final Completer<GoogleMapController> _mapController = Completer();

  /// Set of displayed markers and cluster markers on the map
  final Set<Marker> markers = {};

  /// Minimum zoom at which the markers will cluster
  final int minClusterZoom = 0;

  /// Maximum zoom at which the markers will cluster
  final int maxClusterZoom = 5;

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
      final markerImage =
      await MapHelper.getMarkerImageFromUrl(markerImageUrl);

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
