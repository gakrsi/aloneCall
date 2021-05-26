import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/routes/app_pages.dart';
import 'package:get/get.dart';

/// A chunk of routes taken in the application.
abstract class RoutesManagement{
  /// Go to the home screen.
  static void goToHome() {
    Get.offAllNamed<void>(
        AppRoutes.home
    );
  }

  /// Go to the otp screen.
  static void goToOtpScreen() {
    Get.toNamed<void>(
        AppRoutes.otp
    );
  }

  /// Go to the login screen.
  static void goToLoginScreen() {
    Get.offAllNamed<void>(
        AppRoutes.login
    );
  }

  /// Go to the Phone Number screen.
  static void goToPhoneNumberScreen() {
    Get.toNamed<void>(
        AppRoutes.phoneNumber
    );
  }

  /// Go to the Profile screen.
  static void goToProfileScreen(){
    Get.toNamed<void>(
        AppRoutes.profile
    );
  }

  /// Go to the others profile screen
  static void goToOthersProfileDetail(ProfileModel obj){
    Get.toNamed<void>(
        AppRoutes.detailsPage,
        arguments: obj
    );
  }

  /// Go to the others profile screen
  static void goToOProfileEdit(ProfileModel obj){
    Get.toNamed<void>(
        AppRoutes.editProfile,
        arguments: obj
    );
  }

  /// Go to the others dial call screen
  static void goToOthersDialCall(){
    Get.toNamed<void>(
        AppRoutes.call
    );
  }
  /// Go to the video  call dial screen
  static void goToOthersVideoCallDialView(CallingModel model){
    Get.toNamed<void>(
        AppRoutes.videoCall,
        arguments: model
    );
  }

  /// Go to the audio call dial screen
  static void goToAudioCall(CallingModel callingModel,ProfileModel userModel){
    Get.toNamed<void>(
        AppRoutes.audioCall,
        arguments: [callingModel,userModel]
    );
  }

  /// Go to the payment screen
  static void goToPayment(ProfileModel model,String amount, Map<String,dynamic> data){
    Get.toNamed<void>(
        AppRoutes.payment,
        arguments: [model,amount,data]
    );
  }

  /// Go to the video  call dial screen
  static void goToOthersUserDetailsView(){
    Get.toNamed<void>(
        AppRoutes.detailsPage,
    );
  }
  /// Go to the Random video call screen
  static void goToOthersRandomCallView(){
    Get.toNamed<void>(
      AppRoutes.random,
    );
  }
}

