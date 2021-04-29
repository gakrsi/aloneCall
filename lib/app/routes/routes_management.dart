import 'package:flutter_blueprint/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// A chunk of routes taken in the application.
abstract class RoutesManagement{
  /// Go to the home screen.
  static void goToHome() {
    Get.offAllNamed<void>(
        AppRoutes.home
    );
  }
}