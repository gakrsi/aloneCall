import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';



class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(()=>HomeController());
  }

}