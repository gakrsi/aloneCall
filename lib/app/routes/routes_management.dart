import 'package:alonecall/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// A chunk of routes taken in the application.
abstract class RoutesManagement{
  /// Go to the home screen.
  static void goToHome() {
    Get.offAllNamed<void>(
        AppRoutes.home
    );
  }

  /// Go to the otp screen.
  static void goToOtpScreen() {
    Get.toNamed<void>(
        AppRoutes.otp
    );
  }

  /// Go to the login screen.
  static void goToLoginScreen() {
    Get.toNamed<void>(
        AppRoutes.login
    );
  }

  /// Go to the Phone Number screen.
  static void goToPhoneNumberScreen() {
    Get.toNamed<void>(
        AppRoutes.phoneNumber
    );
  }
}