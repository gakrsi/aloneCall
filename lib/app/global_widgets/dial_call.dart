import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_button.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_user_pic.dart';
import 'package:alonecall/app/modules/call/view/local_widget/rounded_button.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CallView extends StatelessWidget {

  CallView({this.callingModel});
  final CallingModel callingModel;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: ColorsValue.primaryColor,
    body: _body(context),
  );

  Widget _body(BuildContext context)=>SafeArea(
    child: SizedBox(
      height: Dimens.screenHeight,
      width: Dimens.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimens.thirty,),
          Text('gaurav',
              // '${callingModel.callerName}',
              style: Styles.boldWhite16
          ),
          const Text(
            'Calling…',
            style: TextStyle(color: Colors.white60),
          ),
          const DialUserPic(image: 'assets/img/calling_face.png'),
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
              Repository().endVideoCall(callingModel);
            },
            color: Colors.red,
            iconColor: Colors.white,
          )
        ],
      ),
    ),
  );
}
