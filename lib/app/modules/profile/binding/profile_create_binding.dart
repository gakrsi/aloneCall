import 'package:alonecall/app/modules/profile/controller/profile_create_controller.dart';
import 'package:get/get.dart';

class ProfileCreateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileCreateController>(
          () => ProfileCreateController(),
    );
  }
}