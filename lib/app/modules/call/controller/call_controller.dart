import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:get/get.dart';

class CallController extends GetxController with WidgetsBindingObserver{

  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller.initialize().then((_) {
      // if (!mounted) {
      //   return;
      // }
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

}