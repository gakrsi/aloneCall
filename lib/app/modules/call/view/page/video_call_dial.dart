import 'package:alonecall/app/modules/call/controller/call_controller.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_button.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_user_pic.dart';
import 'package:alonecall/app/modules/call/view/local_widget/rounded_button.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCallDialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
        children: [

          _cameraPreview(),
          _body(),
        ]
    ),
  );
  Widget _cameraPreview()=>GetBuilder<CallController>(
    builder:(_controller)=> SizedBox(
      height: Dimens.screenHeight,
      width: Dimens.screenWidth,
      child: CameraPreview(_controller.controller),
    ),
  );


  Widget _body()=>SizedBox(
    height: Dimens.screenHeight,
    width: Dimens.screenWidth,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Dimens.thirty,),
        Text(
            'Anna williams',
            style: Styles.boldWhite16
        ),
        const Text(
          'Calling…',
          style: TextStyle(color: Colors.white60),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            DialButton(
              iconSrc: 'assets/icons/Icon Mic.svg',
              text: 'Audio',
              press: () {},
            ),
            DialButton(
              iconSrc: 'assets/icons/Icon Volume.svg',
              text: 'Microphone',
              press: () {},
            ),
            DialButton(
              iconSrc: 'assets/icons/Icon Video.svg',
              text: 'Video',
              press: () {},
            ),

          ],
        ),
        RoundedButton(
          iconSrc: 'assets/icons/call_end.svg',
          press: () {},
          color: Colors.red,
          iconColor: Colors.white,
        )
      ],
    ),
  );
}
