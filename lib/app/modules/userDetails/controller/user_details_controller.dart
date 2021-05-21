import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController{
  ProfileModel model;
  CallingModel dialModel = CallingModel();
  CallingModel reciModel = CallingModel();

  @override
  void onInit() {
    model = Get.arguments as ProfileModel;
    super.onInit();
  }

  void onClickVideoCall(){
    dialModel
      ..callerUid = model.uid
      ..callerName = 'gaurav'
      ..callerImage = ''
      ..isAudio = false
      ..isDial = true;
    reciModel
      ..callerUid = Repository().currentUser()
      ..callerName = model.name
      ..callerImage = ''
      ..isAudio = false
      ..isDial = false;
    Repository().startVideoCall(reciModel, dialModel);
  }
}