import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  List<CameraDescription> cameras;
  CameraController controller;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller.initialize().then((_){
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