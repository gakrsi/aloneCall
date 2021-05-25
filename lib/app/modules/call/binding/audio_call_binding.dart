import 'package:alonecall/app/modules/call/controller/audio_call_controller.dart';
import 'package:get/get.dart';

class AudioCallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AudioCallController>(() => AudioCallController());
  }

}