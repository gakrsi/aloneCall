import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

final HomeController _con = Get.find();
void showLowBalanceBottomSheetForAudioCall(){
  Get.bottomSheet<void>(
    SizedBox(
      height: Dimens.hundred*3,
      width: Dimens.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your balance is low',style: Styles.black18,),
          SizedBox(
            height: Dimens.ten,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              planContainer('Starter','3 Minutes \n Voice Call','30',_con.model,3,false),
              planContainer('25% Discount','10 Minutes \n Voice Call','100',_con.model,10,false),
            ],
          ),
          SizedBox(
            height: Dimens.ten,
          ),
          InkWell(
              onTap: () {
                Get.back<dynamic>();
              },
              child: showTitle('Back'))
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );
}

void showLowBalanceBottomSheetForVideoCall(){
  Get.bottomSheet<void>(
    SizedBox(
      height: Dimens.hundred*3,
      width: Dimens.screenWidth,
      child: Column(
        children: [
          Text('Your balance is low',style: Styles.black18,),
          SizedBox(
            height: Dimens.ten,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              planContainer('Starter','3 Minutes \n Video Call','50',_con.model,3,true),
              planContainer('25% Discount','10 Minutes \n Video Call','200',_con.model,10,true),
            ],
          ),
          SizedBox(
            height: Dimens.ten,
          ),
          InkWell(
              onTap: () {
                Get.back<dynamic>();
              },
              child: showTitle('Back'))
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );
}

Widget showTitle(String title) => Container(
  margin: EdgeInsets.symmetric(
      horizontal: Dimens.twenty, vertical: Dimens.five),
  height: Dimens.fifty,
  width: Dimens.screenWidth,
  decoration: BoxDecoration(
      color: ColorsValue.primaryColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15)),
  child: Center(
      child: Text(
        title,
        style: Styles.black18,
      )),
);
Widget planContainer(String type,String desc,String price,ProfileModel model,int amount,bool isVideo) =>InkWell(
  onTap: (){
    RoutesManagement.goToPayment(model, price,<String,dynamic>{'type':type,'desc':desc,'price':price,'amount':amount,'is_video':isVideo},);
  },
  child: Container(
    height: Dimens.hundred*1.1,
    width: Dimens.screenWidth/2 - 30,
    decoration: BoxDecoration(
        border: Border.all(color: ColorsValue.lightGreyColor)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 30,
          width: Dimens.hundred*1.2+5,
          decoration: BoxDecoration(
              color: ColorsValue.primaryColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(type,style: Styles.boldWhite16.copyWith(fontSize: 14),)
            ],
          ),
        ),
        SizedBox(height: Dimens.ten,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(desc,style: Styles.black18.copyWith(fontSize: 12),),
            Column(
              children: [
                Text(price,style: Styles.black18.copyWith(fontSize: 30),),
                const Text('INR',style: TextStyle(height: 0.5,fontSize: 10),)

              ],
            )

          ],
        )
      ],
    ),
  ),
);
