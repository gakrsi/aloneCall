import 'package:flutter_blueprint/app/global_widgets/no_internet_widget.dart';
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

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
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
}