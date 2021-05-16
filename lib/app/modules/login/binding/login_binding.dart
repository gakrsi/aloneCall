import 'package:alonecall/app/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}