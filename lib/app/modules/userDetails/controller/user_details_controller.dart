import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  final HomeController _controller = Get.find();
  int age;
  bool isBlocked = false;
  int currentPage = 0;
  bool isUserBlockedMe = false;
  ProfileModel userModel = Get.arguments as ProfileModel;
  CallingModel dialModel = CallingModel();
  Repository repo = Repository();

  List<dynamic> imageUrl = <dynamic>[];
  @override
  void onInit() async {
    isUserBlockedMe = await repo.checkUserIsBlockedWhileCalling(userModel);
    selectImage();
    calculateAge();
    Utility.printDLog('Blocked By User $isUserBlockedMe');
    checkUserIsBlocked();
    super.onInit();
  }

  void selectImage() {
    for (var i in userModel.profileImageUrl) {
      if (i == '') {
      } else {
        imageUrl.add(i);
      }
    }
    print(imageUrl);
  }

  void calculateAge() {
    age = DateTime.now().year - int.parse(userModel.dob.substring(0, 4));
    update();
  }

  void checkUserIsBlocked() async {
    await repo.checkUserIsBlocked(userModel).then((value) {
      if (value) {
        isBlocked = true;
        update();
      }
    });
  }

  void onClickVideoCall() async {
    var balance = await repo.checkVideoBalance();
    if(balance <= 0 && _controller.model.gender == 'Male'){
      RoutesManagement.goToMyProfileView();
    }
    else {
      dialModel
        ..callerUid = Repository().currentUser()
        ..callerName = _controller.model.name
        ..callerImage = _controller.model.profileImageUrl[0] as String
        ..receiverUid = userModel.uid
        ..receiverName = userModel.name
        ..receiverImage = userModel.profileImageUrl[0] as String
        ..isConnected = false
        ..isAudio = false;
      await repo.startVideoCall(dialModel);
      RoutesManagement.goToOthersVideoCallDialView(dialModel);
    }
  }

  void onClickAudioCall() async {
    var balance = await repo.checkAudioBalance();
    if(balance <= 0 && _controller.model.gender == 'Male'){
      RoutesManagement.goToMyProfileView();
    }
    else {
      dialModel
        ..callerUid = Repository().currentUser()
        ..callerName = _controller.model.name
        ..callerImage = _controller.model.profileImageUrl[0] as String
        ..receiverUid = userModel.uid
        ..receiverName = userModel.name
        ..receiverImage = userModel.profileImageUrl[0] as String
        ..isConnected = false
        ..isAudio = true;
      RoutesManagement.goToAudioCall(dialModel);
    }
  }

  void shoeBlockUserBottomSheet() {
    Get.bottomSheet<dynamic>(Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          isBlocked ? repo.unBlockUser(userModel) : repo.blockUser(userModel);
          isBlocked = !isBlocked;
          update();
          Get.back<dynamic>();
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
              isBlocked ? 'UnBlock' : 'Block User',
              style: Styles.boldBlack16,
            ),
          ),
        ),
      ),
    ));
  }

  void onChangedPage(int index) {
    currentPage = index;
    update();
  }
}
