import 'package:alonecall/app/utils/string_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

/// Common class to add check for permissions.
abstract class Permissions {
  /// Check for storage permission if given or denied
  static Future<bool> checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isRestricted || status.isDenied) {
      if (await Permission.storage
          .request()
          .isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      Utility.showError('storagePermissionError');
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return true;
  }

  /// Check for camera permission if given or denied
  static Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isRestricted || status.isDenied) {
      if (await Permission.camera
          .request()
          .isGranted) {
        return true;
      }
      return false;
    }
    if (status.isRestricted) {
      Utility.showError('Camera Permission');
      return false;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    return true;
  }

  /// Check for location permission if given or denied
  ///
  /// [openSetting] : this tells if user should be redirected to setting page
  ///                 if permission is restricted. This is required because
  ///                 for api calls we don't want the user to go to settings
  ///                 and enable the location. It will return false and default
  ///                 values will be chosen for the location.
  static Future<bool> checkLocationPermission(bool openSetting) async {
    var status = await Permission.location.status;
    if (status.isRestricted || status.isDenied) {
      if (await Permission.location
          .request()
          .isGranted) {
        return checkIfLocationServiceEnabled(openSetting);
      }
      return false;
    }
    if (status.isRestricted) {
      if (openSetting) {
        Utility.showError(StringConstants.locationPermissionError);
      }
      return false;
    }
    if (status.isPermanentlyDenied) {
      if (openSetting) {
        await geo.Geolocator.openLocationSettings();
      }
      return false;
    }
    return checkIfLocationServiceEnabled(openSetting);
  }

  /// Check for location service is enabled or not
  /// if not then show a dialog for confirmation
  static Future<bool> checkIfLocationServiceEnabled(bool openSetting) async {
    if (await geo.Geolocator.isLocationServiceEnabled()) {
      return true;
    } else {
      if (openSetting) {
        Utility.askToEnableServiceFromSetting(
          StringConstants.locationService,
          StringConstants.enableLocationService,
        );
      }
      return false;
    }
  }
}
