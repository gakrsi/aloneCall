import 'package:flutter/material.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      GetBuilder<LoginController>(
        builder: (_con) =>
            Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: Dimens.screenHeight - 150,
                      left: Dimens.screenWidth - 150,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsValue.primaryColor),
                      ),
                    ),
                    //_skipButton(),
                    SizedBox(
                      height: Dimens.screenHeight,
                      width: Dimens.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 130,
                            ),
                            _logo(),
                            InkWell(
                                onTap: () => _con.loginWithPhone(),
                                child: _button(
                                    'Continue with Phone number', '', false)),
                            const SizedBox(
                              height: 30,
                            ),
                            _divider(),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () => _con.loginWithGoogle(),
                              child: _button('Sign in with Google     ',
                                  'assets/img/google.png', true),
                            ),
                            /*const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: ()=>_con.loginWithFacebook(),
                          child: _button('Sign in with FaceBook',
                              'assets/img/facebook.png', true),
                        )*/
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      );

  Widget _logo() =>
      Padding(
        padding: const EdgeInsets.all(35.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(
                  'assets/img/logos/AloneCallwithborderbackground.jpg'))),
        ),
      );

  Widget _button(String title, String image, bool isImg) =>
      Container(
        height: Dimens.sixty,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              colors: [Colors.white70, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isImg
                ? Container(
              height: Dimens.twentyThree,
              width: Dimens.twentyThree,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image))),
            )
                : Container(),
            const SizedBox(width: 10,),
            Text(
              title,
              style: Styles.black18,
            ),
          ],
        ),
      );

  Widget _divider() =>
      Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'or',
              style: Styles.black12,
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      );
}

//   Widget _skipButton()=>Positioned(
//     bottom: Dimens.twenty,
//     left: Dimens.screenWidth - (Dimens.hundred + Dimens.twenty),
//     child: Container(
//       height: Dimens.fourty,
//       width: Dimens.eighty,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(Dimens.thirty),
//         gradient: const LinearGradient(
//           colors: [Colors.white70, Colors.white],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//           boxShadow: [
//       BoxShadow(
//       color: Colors.grey.withOpacity(0.2),
//       spreadRadius: 1,
//       blurRadius: 2,
//       offset: const Offset(0, 1),
//     )]
//       ),
//       child: Center(
//         child: Text('Skip',style: Styles.black18,),
//       ),
//     ),
//   );
// }
