import 'package:alonecall/app/utils/utility.dart';
import 'package:permission_handler/permission_handler.dart';

/// Common class to add check for permissions.
abstract class Permissions {
  /// Check for storage permission if given or denied
  static Future<bool> checkStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isRestricted || status.isDenied) {
      if (await Permission.storage.request().isGranted) {
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
      if (await Permission.camera.request().isGranted) {
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
}
