import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/data/service/call_service.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickUpScreen extends StatelessWidget {
  PickUpScreen({this.callingModel});
  final CallingModel callingModel;
  @override
  Widget build(BuildContext context) => GetBuilder<CallService>(
    builder:(_con)=> Scaffold(
          backgroundColor: ColorsValue.primaryColor,
          body: _body(context,_con),
        ),
  );

  Widget _body(BuildContext context,CallService con) => SafeArea(
        child: SizedBox(
          height: Dimens.screenHeight,
          width: Dimens.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimens.thirty,
              ),
              circularPhoto(imageUrl: callingModel.callerImage),
              SizedBox(
                height: Dimens.twenty,
              ),
              Text('${callingModel.callerName}',
                  // '${callingModel.callerName}',
                  style: Styles.boldWhite16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Repository().endVideoCall(callingModel);
                      con.assetsAudioPlayer.pause();
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.phone,
                        size: 35,
                        color: Colors.white,
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      con.assetsAudioPlayer.pause();
                      con.updateCallStatusReceived();
                      Get.back<dynamic>();
                      callingModel.isAudio
                          ? RoutesManagement.goToAudioCall(callingModel)
                          : RoutesManagement.goToOthersVideoCallDialView(
                              callingModel);
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.phone,
                        size: 35,
                        color: Colors.white,
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
