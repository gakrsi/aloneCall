import 'package:alonecall/app/modules/edit_profile/controller/profile_edit_controller.dart';
import 'package:alonecall/app/modules/profile/controller/profile_create_controller.dart';
import 'package:get/get.dart';

class ProfileEditBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileEditController>(
          () => ProfileEditController(),
    );
  }
}