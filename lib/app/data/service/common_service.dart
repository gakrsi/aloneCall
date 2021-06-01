import 'dart:async';
import 'dart:io';

import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/location_details.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/network_constant.dart';
import 'package:alonecall/app/utils/permissions.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CommonService extends GetxController{
  /// This is used for internet change listener
  StreamSubscription _streamSubscription;


  /// Location text editing controller
  final TextEditingController locationTextEditingController =
  TextEditingController();

  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  @override
  void onInit() {
    _checkForInternetConnectivity();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  /// Starts the check for internet connectivity. If there is no connection
  /// with the internet a text message will be shown. If the application
  /// is not able to connect to the internet even if the connection is available
  /// will ask the user to check the internet permission.
  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        Utility.closeDialog();
      } else {
        Utility.showNoInternetDialog();
      }
    });
  }

  final picker = ImagePicker();
  /// Opens the gallery/file application for the user to pick the image.
  Future<String> getImageFromGallery(int index) async {
    if (await Permissions.checkStoragePermission()) {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
          imageQuality: 50
      );
      if (pickedFile != null) {
        print(pickedFile);
        return await _openCropImageOption(pickedFile,index);
      } else {
        Utility.showError(StringConstants.imageNotFoundError);
      }
    }
    return '';
  }

  /// Opens the camera application for the user to pick the image.
  Future<String> getImageFromCamera(int index) async {
    if (await Permissions.checkCameraPermission()) {
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50
      );
      if (pickedFile != null) {
        return await _openCropImageOption(pickedFile,index);
      } else {
        Utility.showError(StringConstants.imageNotFoundError);
      }
    }
    return '';
  }
  /// Opens the crop image page for the user to crop the selected image.
  ///
  /// [pickedFile] : The file which needs to be cropped.
  Future<String> _openCropImageOption(PickedFile pickedFile, int index) async {
    print('_openCropImageOption');

    // var croppedFile = await ImageCropper.cropImage(
    //     sourcePath: pickedFile.path,
    //     cropStyle: CropStyle.circle,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //     ],
    //     androidUiSettings: const AndroidUiSettings(
    //       toolbarTitle: StringConstants.appName,
    //       toolbarColor: Colors.black,
    //       toolbarWidgetColor: Colors.white,
    //       initAspectRatio: CropAspectRatioPreset.original,
    //       lockAspectRatio: true,
    //     ),
    //     iosUiSettings: const IOSUiSettings(
    //       minimumAspectRatio: 1.0,
    //     ));
    var file = File(pickedFile.path);
    if (pickedFile != null) {
      Utility.showLoadingDialog();
      var url = await uploadImageOnCloudinary(file,index);
      Utility.closeDialog();
      if (url.isNotEmpty) {
        return url;
      } else {
        Utility.showError(StringConstants.imageNotFoundError);
      }
    } else {
      Utility.showError(StringConstants.imageNotFoundError);
    }
    return '';
  }

  /// Returns a Future string which will be a url of the image
  /// send to the FireStore.
  ///
  /// [fileToUpload] : The file which needs to upload.
  Future<String> uploadImageOnCloudinary(File fileToUpload,int index) async {
    print('uploadImageOnCloudinary');
    try {
      return await Repository().uploadProfileImage(fileToUpload,index);
    } on Exception {
      Utility.showError('Error on upload file on Sever');
    }
    return '';
  }


  /// This will be used to show the google map only if the lat long
  /// is updated by the user
  ///
  /// if true show the google map
  bool isLatLngUpdated = false;

  /// This will be used to know if the location data was taken from
  /// search or from current location or from google map movement
  ///
  /// if true the location was from search
  bool isFromSearch = false;

  /// Location Details
  LocationData userSelectedLocation;


  /// A google map controller for controlling the google map details
  /// depending on the lat long or change in the location in the map
  GoogleMapController _mapController;

  /// [controller] will be assigned to the [_mapController]
  /// for handling the google map location and change listener
  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  double lat = 0.0;
  double long = 0.0;

  /// Show the map layout when lat long is updated
  ///
  /// [lat] : the latitude position of the map
  /// [long] : the longitude position of the map
  void showMapLayout(double lat, double long) async {
    await _mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    isLatLngUpdated = true;
    update();
  }

  /// Gives the current location of the user which will be shown in
  /// the location field.
  void getCurrentLocation() async {
    if (await Permissions.checkLocationPermission(true) != null) {
      // Utility.showLoadingDialog();
      var currentLocationData = await Utility.getCurrentLocation();
      if (currentLocationData != null) {
        // Utility.closeDialog();
        lat = currentLocationData.latitude;
        long = currentLocationData.longitude;
        Utility.printDLog('$lat  $long');
        isFromSearch = false;
        showMapLayout(
            currentLocationData.latitude, currentLocationData.longitude);
      } else {
        Utility.showError(
          StringConstants.errorGettingCurrentLocation,
        );
      }
    }
  }
  /// When the google map is moved this method will get the updated position
  /// of the google map in [position]
  void getCameraMoveUpdate(CameraPosition position) async {
    lat = position.target.latitude; /// 24.9042965
    long = position.target.longitude; /// 84.1804839
  }

  /// A method which will be triggered when the google map is idle.
  void cameraIdle() async {
    if (lat != 0 && long != 0) {
      var locationData = await Utility.getAddressThroughLatLng(
        lat,
        long,
      );
      if (locationData != null) {
        userSelectedLocation = Utility.getLocationData(locationData);
        if (userSelectedLocation != null) {
          if (!isFromSearch) {
            locationTextEditingController.text = locationData.addressLine;
          }
        }
      } else {
        Utility.showError(
          StringConstants.errorWhileGettingLocation,
        );
      }
    }
    isFromSearch = false;
  }

  /// Allows the user to search for the location by google place auto complete
  /// and added session token for grouping the quarries. For more details can
  /// go the [Session Tokens](https://developers.google.com/places/web-service/session-tokens).
  ///
  /// [searchedText] : The text which was already there in the text field.
  void openLocationSearch(String searchedText) async {
    var selectedLocation = await PlacesAutocomplete.show(
      context: Get.context,
      apiKey: NetworkConstants.googleApiKey,
      mode: Mode.overlay,
      sessionToken: Utility.generateV4(),
      startText: searchedText,
      logo: null,
    );
    Utility.showLoadingDialog();
    if (selectedLocation != null) {
      var locationPosition =
      await Utility.getPosition(selectedLocation.description);
      if (locationPosition != null) {
        lat = locationPosition.latitude;
        long = locationPosition.longitude;
        isFromSearch = true;
        locationTextEditingController.text = selectedLocation.description;
        showMapLayout(locationPosition.latitude , locationPosition.longitude);
      } else {
        Utility.showError(
          StringConstants.errorWhileGettingLocation,
        );
      }
      Utility.closeDialog();
    } else {
      Utility.showError(
        StringConstants.errorWhileGettingLocation,
      );
    }
  }
}