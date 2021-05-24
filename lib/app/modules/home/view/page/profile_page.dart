import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/call/view/local_widget/dial_user_pic.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder:(_con) =>Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Dimens.screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:Dimens.sixTeen),
            child: Column(
              children: [
                SizedBox(height: Dimens.eighty,),
                const DialUserPic(image: 'assets/img/calling_face.png'),
                SizedBox(height: Dimens.ten,),
                InkWell(
                    onTap: (){
                      RoutesManagement.goToPayment(_con.model);
                    },
                    child: showTitle(' Coins: ${_con.model.coin}')),
                SizedBox(height: Dimens.ten,),
                showTitle(_con.model.name),
                SizedBox(height: Dimens.ten,),
                showTitle(_con.model.gender),
                SizedBox(height: Dimens.ten,),
                showTitle(_con.model.country),
                SizedBox(height: Dimens.ten,),
                showTitle(_con.model.lang),
                SizedBox(height: Dimens.ten,),
                InkWell(
                  onTap: (){
                    Repository().logout();
                  },
                    child: showTitle('Logout'))
              ],
            ),
          ),
        ),
      ),
    ),
  );
  Widget showTitle(String title)=>Container(
    margin: EdgeInsets.symmetric(horizontal:Dimens.twenty,vertical: Dimens.five),
    height: Dimens.fifty,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
      color: ColorsValue.primaryColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15)
    ),
    child: Center(child: Text(title,style: Styles.black18,)),
  );
}
