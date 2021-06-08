import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingController extends GetxController{

  void shoeBlockUserBottomSheet(ProfileModel userModel) {
    Get.bottomSheet<dynamic>(Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Repository().unBlockUser(userModel);
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'UnBlock User',
              style: Styles.boldBlack16,
            ),
          ),
        ),
      ),
    ));
  }

}