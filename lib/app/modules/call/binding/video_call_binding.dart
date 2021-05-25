import 'package:alonecall/app/modules/call/controller/video_call_controller.dart';
import 'package:get/get.dart';

class VideoCallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VideoCallController>(() => VideoCallController());
  }

}