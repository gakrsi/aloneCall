import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/friebase_key_constant.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_user_pic.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PickUpScreen extends StatelessWidget {

  PickUpScreen({this.callingModel}){
    FirebaseFirestore.instance.collection(FirebaseConstant.user).doc(callingModel.callerUid).get().then((value){
      userModel = ProfileModel.fromJson(value.data());
    });
  }
  final CallingModel callingModel;
  ProfileModel userModel;

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
          Text('${callingModel.callerName}',
              // '${callingModel.callerName}',
              style: Styles.boldWhite16
          ),
          const DialUserPic(image: 'assets/img/calling_face.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  Repository().endVideoCall(callingModel);
                },
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: const Center(child:  Icon(Icons.phone,size: 35,color: Colors.white,)),
                ),
              ),

              InkWell(
                onTap: (){
                  callingModel.isAudio?RoutesManagement.goToAudioCall(callingModel, userModel):
                  RoutesManagement.goToOthersVideoCallDialView(callingModel);
                },
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Center(child:  Icon(Icons.phone,size: 35,color: Colors.white,)),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
