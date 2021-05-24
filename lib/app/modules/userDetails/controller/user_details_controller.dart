import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController{

  final HomeController _controller = Get.find();
  int age;
  int currentPage = 0;
  ProfileModel model;
  CallingModel dialModel = CallingModel();

  List<dynamic> imageUrl = <dynamic>[];

  void selectImage(){
    for(var i in model.profileImageUrl){
      if(i != null){
        imageUrl.add(i);
      }
    }
    print(imageUrl);
  }

  void calculateAge(){
    age = DateTime.now().year - int.parse(model.dob.substring(0,4));
    update();
  }

  @override
  void onInit() {
    model = Get.arguments as ProfileModel;
    selectImage();
    calculateAge();
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
    RoutesManagement.goToOthersVideoCallDialView(dialModel);
  }
  void onChangedPage(int index){
    currentPage = index;
    update();
  }
}