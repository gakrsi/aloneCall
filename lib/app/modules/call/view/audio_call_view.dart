import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/call/controller/audio_call_controller.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_button.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_user_pic.dart';
import 'package:alonecall/app/modules/call/view/local_widget/rounded_button.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimens.thirty,
                  ),
                  Text(_con.userModel.name,
                      // '${callingModel.callerName}',
                      style: Styles.boldWhite16),
                  Text(
                    !_con.userModel.online ? 'Calling…' : 'Ringing',
                    style: const TextStyle(color: Colors.white60),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30 / 192 * 192),
                    height: 192,
                    width: 192,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.02),
                          Colors.white.withOpacity(0.05)
                        ],
                        stops: [.5, 1],
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: _con.userModel.profileImageUrl[0] as String,
                        placeholder: (context, url) => Container(
                          height: Dimens.screenHeight,
                          width: Dimens.screenWidth,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/img/loading.gif'),
                                  fit: BoxFit.cover)),
                        ),
                        errorWidget: (context, url, dynamic error) =>
                            const Icon(Icons.error),
                      ),
                    ),
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
                    press: () {
                      Repository().endVideoCall(_con.callingModel);
                    },
                    color: Colors.red,
                    iconColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
