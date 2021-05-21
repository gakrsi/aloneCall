import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';



class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true,);
  }

}