import 'package:alonecall/app/modules/userDetails/controller/user_details_controller.dart';
import 'package:get/get.dart';

class UserDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsController>(() => UserDetailsController());
  }
}