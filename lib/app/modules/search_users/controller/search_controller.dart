import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{

  final HomeController con = Get.find();

  String item = ' ';
  void onChangedValue(String value){
    item = value;
    update();
  }

}