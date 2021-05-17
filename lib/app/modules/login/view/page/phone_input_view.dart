import 'package:alonecall/app/global_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/modules/login/controller/login_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:get/state_manager.dart';


import 'package:alonecall/app/theme/theme.dart';

class PhoneNumberView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black87,
    body: GetBuilder<LoginController>(
      builder:(_con)=> Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimens.fourty),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logoAndTitle(),
                SizedBox(height: Dimens.thirty,),
                _loginAndSignUpTitle(),
                SizedBox(height: Dimens.twenty,),
                _mobileTextField(_con),
                SizedBox(height: Dimens.twenty,),
                InkWell(
                    onTap: (){
                      RoutesManagement.goToOtpScreen();
                      // _con.onPressedLoginButton();
                    },
                    child: PrimaryButton(title: StringConstants.continueButton,disable: _con.showLoginButton,)
                ),
                SizedBox(height: Dimens.twenty,),
              ],
            ),
          ),
          if(_con.pageStatus == PageStatus.loading)
            Container(
              height: Dimens.screenHeight,
              width:Dimens.screenWidth,
              color: Colors.blueGrey.withOpacity(Dimens.one/Dimens.two),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    ),
  );
  /// This Widget return the logo and tit/e of the app
  Widget _logoAndTitle() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: Dimens.eighty,
          width: Dimens.eighty*2,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/logo1.png'),
                  fit: BoxFit.cover
              )
          ),
        ),

      ],
    ),
  );

  /// This Widget return which show Login and SignUp title
  Widget _loginAndSignUpTitle() => Text(StringConstants.loginOrSignUp,style: Styles.white16,);


  /// Function return TextField
  Widget _mobileTextField(LoginController con) => TextFormField(
    style: Styles.white16.copyWith(height: Dimens.one),
    onChanged: (value)=>con.enableLoginButton(value),
    decoration: InputDecoration(
      labelText: StringConstants.phone,
      labelStyle: Styles.white12,
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.three),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white54,
          width: 2.0,
        ),
      ),
    ),
  );
}