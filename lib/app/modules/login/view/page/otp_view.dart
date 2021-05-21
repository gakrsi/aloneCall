import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:alonecall/app/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:alonecall/app/theme/theme.dart';

class OtpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<LoginController>(
    builder: (_controller) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: Dimens.zero,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: Dimens.screenWidth,
              height: Dimens.screenHeight,
              child: Padding(
                padding: EdgeInsets.all(Dimens.twentySix),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(StringConstants.verifyWithOtp,style: Styles.boldBlack26,),
                    SizedBox(height: Dimens.ten,),
                    Text('sent via sms to ${_controller.number}',style: Styles.grey14,),
                    SizedBox(height: Dimens.fifty,),
                    _otpTextField(context,_controller),
                    Text(StringConstants.tryingToAutoFill,style: Styles.grey14,),
                    SizedBox(height: Dimens.fifty,),
                    RichText(
                      text: TextSpan(
                          text: StringConstants.havingTroubleLogin,
                          style: Styles.grey14,
                          children: [
                            TextSpan(text:StringConstants.getHelp,style: TextStyle(color: ColorsValue.secondaryColor,fontSize: Dimens.fourteen),)
                          ]
                      ),
                    ),
                    SizedBox(height: Dimens.thirty,),
                    InkWell(
                      onTap: () {
                        _controller.loginWithOtp();
                      },
                      hoverColor: Colors.blueGrey,
                      child: Container(
                        height: Dimens.fifty + Dimens.six,
                        width: Dimens.hundred * Dimens.three + Dimens.fifty,
                        decoration: BoxDecoration(
                          color: _controller.hasError
                              ? ColorsValue.primaryColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(Dimens.five),
                        ),
                        child: Center(
                            child: Text(StringConstants.login, style: Styles.white16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(_controller.pageStatus == PageStatus.loading)
              Container(
                height: Dimens.screenHeight,
                width:Dimens.screenWidth,
                color: Colors.blueGrey.withOpacity(Dimens.one/Dimens.two),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        )),
  );

  /// This Function return otp TextField
  Widget _otpTextField(BuildContext context,LoginController _controller)=>PinCodeTextField(
    appContext: context,
    pastedTextStyle: TextStyle(
      color: Colors.green.shade600,
      fontWeight: FontWeight.bold,
    ),
    length: 6,
    blinkWhenObscuring: true,
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(3),
      fieldHeight: 55,
      fieldWidth: 40,
      borderWidth: 1,
      activeColor: Colors.white,
      activeFillColor: Colors.white,
      inactiveColor: Colors.white,
      inactiveFillColor: Colors.white,
      selectedColor: Colors.white,
      selectedFillColor: Colors.white,
    ),
    cursorColor: Colors.black,
    animationDuration: const Duration(milliseconds: 300),
    enableActiveFill: true,
    keyboardType: TextInputType.number,
    boxShadows: [
      const BoxShadow(
        color: Colors.black,
        blurRadius:1,
      ),
    ],
    onChanged: (value) {
      print(value);
      _controller.onPressedLogin(value);
    },
    beforeTextPaste: (text) {
      print('Allowing to paste $text');
      return true;
    },
  );
}
