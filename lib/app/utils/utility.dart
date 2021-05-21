import 'package:alonecall/app/global_widgets/call_pickup_widget.dart';
import 'package:alonecall/app/modules/call/view/call_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:alonecall/app/data/model/location_details.dart';
import 'package:alonecall/app/global_widgets/no_internet_widget.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geocoder;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

abstract class Utility{
  /// Print debug log.
  ///
  /// [message] : The message which needed to be print.
  static void printDLog(String message) {
    Logger().d('$message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(String message) {
    Logger().i('$message');
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    Logger().e('$message');
  }

  /// Show a loading progress indicator
  /// on top of the screen.
  static void showLoadingDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorsValue.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Show no internet dialog if there is no
  /// internet available.
  static void showNoInternetDialog() {
    closeDialog();
    Get.dialog<void>(
      NoInternetWidget(),
      barrierDismissible: false,
    );
  }

  /// Show no internet dialog if there is no
  /// internet available.
  static void showIncomingCallDialog() {
    closeDialog();
    Get.dialog<void>(
      CallPickup(),
      barrierDismissible: false,
    );
  }

  /// Returns a list of booleans by validating [password].
  ///
  /// for at least one upper case, at least one digit,
  /// at least one special character and and at least 6 characters long
  /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])             // should contain at least one upper case
  ///   (?=.*?[0-9])            // should contain at least one digit
  ///  (?=.*?[!@#\$&*~]).{8,}   // should contain at least one Special character
  /// $
  static List<bool> passwordValidator(String password) {
    var validationStatus = <bool>[false, false, false];
    validationStatus[0] = password.length >= 6;
    validationStatus[1] = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    validationStatus[2] = RegExp(r'(?=.*?[0-9])').hasMatch(password);
    return validationStatus;
  }

  /// Return true if [email] is a valid email id.
  static bool emailValidator(String email) => EmailValidator.validate(email);

  /// Show an error snack bar.
  ///
  /// [message] : error message.
  static void showError(String message) {
    closeSnackBar();
    closeDialog();
    closeBottomSheet();
    if (message == null || message.isEmpty) return;
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: Styles.white16,
      ),
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back<void>();
          }
        },
        child: Text(
          'Okay',
          style: Styles.white14,
        ),
      ),
      backgroundColor: Colors.red,
      margin: Dimens.edgeInsets15,
      borderRadius: Dimens.fifteen,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  /// Close any open snack bar.
  static void closeSnackBar() {
    if (Get.isSnackbarOpen ?? false) Get.back<void>();
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open bottom sheet.
  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  }

  /// Get all location details from the address object.
  ///
  /// [locationDetails] : the location details got from geocoder.
  static LocationData getLocationData(geocoder.Address locationDetails) =>
      LocationData(
        placeName: locationDetails.subLocality ,
        addressLine1: locationDetails.addressLine,
        addressLine2: locationDetails.adminArea,
        area: locationDetails.subAdminArea,
        city: locationDetails.locality,
        postalCode: locationDetails.postalCode,
        country: locationDetails.countryName,
        latitude: locationDetails.coordinates.latitude,
        longitude: locationDetails.coordinates.longitude,
      );

  /// Get current lat long of the device.
  static Future<Position> getCurrentLatLng() async =>
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  /// Get current location in string.
  static Future<LocationData> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    var locationDetails = await getAddressThroughLatLng(position.latitude, position.longitude);
    return getLocationData(locationDetails);
  }

  /// Get the location name by giving the lat long.
  ///
  /// [latitude] : latitude of the location.
  /// [longitude] : longitude of the location.
  static Future<geocoder.Address> getAddressThroughLatLng(
      double latitude, double longitude) async {
    geocoder.Address first;
    if (latitude != null && longitude != null) {
      final coordinates = geocoder.Coordinates(latitude, longitude);
      var addresses = await geocoder.Geocoder.local
          .findAddressesFromCoordinates(coordinates);
      if (addresses != null || addresses.isNotEmpty) {
        first = addresses.first;
      } else {
        first = null;
      }
    }
    return first;
  }
}