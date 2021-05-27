import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/call/controller/audio_call_controller.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_button.dart';
import 'package:alonecall/app/modules/call/view/local_widget/rounded_button.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alonecall/app/theme/dimens.dart';

class AudioCallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorsValue.primaryColor,
        body: GetBuilder<AudioCallController>(
          builder: (_con) => SafeArea(
            child: SizedBox(
              height: Dimens.screenHeight,
              width: Dimens.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimens.hundred,
                  ),
                  circularPhoto(
                    imageUrl: _con.isNotDial
                        ? _con.callingModel.callerImage
                        : _con.callingModel.receiverImage,
                  ),
                  SizedBox(
                    height: Dimens.thirty,
                  ),
                  Text(
                      _con.isNotDial
                          ? _con.callingModel.callerName
                          : _con.callingModel.receiverName,
                      style: Styles.boldWhite16),
                  Text(
                    _con.callStatusText,
                    style: const TextStyle(color: Colors.white60),
                  ),
                  Expanded(child: Container()),
                  _toolBar(_con),
                  SizedBox(
                    height: Dimens.thirty,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _toolBar(AudioCallController con) => Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              DialButton(
                iconSrc: 'assets/icons/Icon Mic.svg',
                text: 'Audio',
                press: () {
                  con.switchMicrophone();
                },
              ),
              DialButton(
                iconSrc: 'assets/icons/Icon Volume.svg',
                text: 'Microphone',
                press: () {
                  con.switchSpeakerphone();
                },
              ),
            ],
          ),
          RoundedButton(
            iconSrc: 'assets/icons/call_end.svg',
            press: () {
              print('End button pressed');
              if(con.isJoined){
                Repository().endVideoCall(con.callingModel);
              }
              else{
                Get.back<dynamic>();
              }
            },
            color: Colors.red,
            iconColor: Colors.white,
          )
        ],
      );
}
