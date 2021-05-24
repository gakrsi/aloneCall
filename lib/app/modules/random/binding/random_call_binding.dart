import 'package:alonecall/app/modules/random/controller/random_call_controller.dart';
import 'package:get/get.dart';

class RandomCallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RandomCallController>(() => RandomCallController());
  }

}