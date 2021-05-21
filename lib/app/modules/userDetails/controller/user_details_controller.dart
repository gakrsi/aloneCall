import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController{

  final HomeController _controller = Get.find();

  ProfileModel model;
  CallingModel dialModel = CallingModel();

  @override
  void onInit() {
    model = Get.arguments as ProfileModel;
    super.onInit();
  }

  void onClickVideoCall(){
    dialModel
      ..callerUid = Repository().currentUser()
      ..receiverUid = model.uid
      ..callerName = _controller.model.name
      ..callerImage = ''
      ..isAudio = false;
    Repository().startVideoCall(dialModel);
  }
}