import 'package:alonecall/app/modules/call/controller/call_controller.dart';
import 'package:get/get.dart';

class CallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CallController>(() => CallController());
  }

}