import 'dart:async';
import 'dart:io';

import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/permissions.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CommonService extends GetxController{
  /// This is used for internet change listener
  StreamSubscription _streamSubscription;


  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  @override
  void onInit() {
    // print(Repository().currentUser());
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
}