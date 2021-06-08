import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alonecall/app/modules/login/view/page/otp_view.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  ///Firebase Auth part
  ///Instance of Firebase Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  String localVerificationId = '';

  /// Flag to show login button
  bool showLoginButton = false;

  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  /// Variable to store mobile number
  String number = '';

  ///Function call when pressed login button
  void onPressedLoginButton() async {
    if (showLoginButton) {
      await loginWithPhoneNumber(number);
    } else {
      Utility.showError('Enter Correct phone number');
    }
  }

  ///Function is used to login user with phone number and otp
  Future<void> loginWithPhoneNumber(String phoneNumber) async {
    Utility.showLoadingDialog();
    try {
      await auth
          .verifyPhoneNumber(
              phoneNumber: '+91$phoneNumber',
              timeout: const Duration(seconds: 60),
              verificationCompleted: (AuthCredential authCredential) {
                auth.signInWithCredential(authCredential).then((result) {
                  RoutesManagement.goToHome();
                }).catchError((String e) {
                  print('Inside verification error');
                  Utility.printELog(e.toString());
                });
              },
              verificationFailed: (authException) {
                Utility.printELog(authException.message);
              },
              codeSent: (String verificationId, [int forceResendingToken]) {
                localVerificationId = verificationId;
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                localVerificationId = verificationId;
              })
          .whenComplete(() {
            Utility.closeDialog();
        RoutesManagement.goToOtpScreen();
      });
    } catch (onError) {
      Utility.printELog(onError.toString());
    }
  }

  void loginWithOtp() async {
    Utility.showLoadingDialog();
    final credential = PhoneAuthProvider.credential(verificationId: localVerificationId, smsCode: pin);
    Utility.printDLog('Inside login with otp');
    try{
      await auth.signInWithCredential(credential).then((value) {
        Repository().checkProfileCreate().then((value) {
          Utility.closeDialog();
          value
              ? RoutesManagement.goToHome()
              : RoutesManagement.goToProfileScreen();
        });
      });
    } catch  (e){
      Utility.closeDialog();
      Utility.showError('${e.message}');
    }

  }

  /// Function to update the [showLoginButton] flag
  void enableLoginButton(String value) {
    if (value.length == 10) {
      number = value;
      showLoginButton = true;
    } else {
      showLoginButton = false;
    }
    update();
  }

  /// Function call on Pressed Login With Phone Number button
  void loginWithPhone() {
    RoutesManagement.goToPhoneNumberScreen();
  }

  /// Function call on Pressed Login With Google button
  void loginWithGoogle() {
    signInWithGoogle().then((value) {
      Repository().checkProfileCreate().then((value) {
        value
            ? RoutesManagement.goToHome()
            : RoutesManagement.goToProfileScreen();
      });
    });
  }

  /// Function call on Pressed Login With FaceBook button
  void loginWithFacebook() {
    try {
      signInWithFacebook().then((value) {
        Repository().checkProfileCreate().then((value) {
          value
              ? RoutesManagement.goToHome()
              : RoutesManagement.goToProfileScreen();
        });
      });
    } catch (e) {
      Utility.showError('Something went wrong');
    }
  }

  /// Function call on Pressed Skip button
  void skipButton() {
    RoutesManagement.goToHome();
  }

  Future<UserCredential> signInWithFacebook() async {
    final result = await FacebookAuth.instance.login() as AccessToken;
    final facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// ############################################### [OtpView] ################################################################

  /// From Here all Element in for [OtpView]

  TextEditingController textEditingController = TextEditingController();

  bool showCounter = true;
  bool hasError = false;
  String pin = '';
  final formKey = GlobalKey<FormState>();

  void onPressedLogin(String value) {
    if (value.length == 6) {
      hasError = true;
      pin = value;
    }
    update();
  }

  void updateCounterView() {
    showCounter = !showCounter;
    update();
  }

  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}
