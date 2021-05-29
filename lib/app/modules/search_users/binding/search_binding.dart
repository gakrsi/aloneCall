import 'package:alonecall/app/modules/search_users/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }

}