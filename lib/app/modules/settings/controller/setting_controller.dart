import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';


class SettingController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void rateUs() async {

    final inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
    }
  }

  void aboutUs(){}
}