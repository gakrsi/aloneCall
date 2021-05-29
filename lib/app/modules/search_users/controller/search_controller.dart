import 'package:get/get.dart';

class SearchController extends GetxController{
  String item = ' ';
  void onChangedValue(String value){
    item = value;
    update();
  }

}