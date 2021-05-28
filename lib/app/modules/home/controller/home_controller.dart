import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/local_widget/profile_edit_dialog.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  /// Current index in [HomeView]
  int currentTab = 0;
  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  ProfileModel model = ProfileModel();

  final List<BottomNavigationBarItem> tab = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ' '),
  ];

  void changeTab(int index) {
    currentTab = index;
    update();
  }

  String gender(){
    if(model.gender == 'Female'){
      return 'Male';
    }
    return 'Female';
  }

  @override
  void onInit() async {
    var data = await Repository().getProfile();
    print(data);
    model = ProfileModel.fromJson(data);
    super.onInit();
  }

  ///##########################################[ProfileView]###############################################################################
  int profileCurrentTab = 0 ;

  void changeProfileTab(int index){
    profileCurrentTab = index;
    update();
  }
  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }
  void showEditProfileDialog() {
    closeDialog();
    Get.bottomSheet<void>(
      ProfileEditDialog(model: model,),
    );
  }

  ///#########################################################################################################################








  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}