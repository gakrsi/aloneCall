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
        builder: (_con) => Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: Dimens.screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.sixTeen),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimens.thirty,
                    ),
                    const DialUserPic(image: 'assets/img/calling_face.png'),
                    Text(
                        '${_con.model.name} ${DateTime.now().year - int.parse(_con.model.dob.substring(0, 4))}'),
                    SizedBox(
                      height: Dimens.ten,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          height: Dimens.fifty,
                          width: Dimens.hundred + Dimens.thirty,
                          decoration: BoxDecoration(
                              color: ColorsValue.primaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: Dimens.twenty,
                                ),
                                Text(
                                  '${_con.model.coin} Coins',
                                  style: Styles.black18,
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          height: Dimens.fifty,
                          width: Dimens.hundred + Dimens.thirty,
                          decoration: BoxDecoration(
                              color: ColorsValue.primaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.video_call,
                                  size: Dimens.twenty,
                                ),
                                Text(
                                  '${_con.model.coin} Coins',
                                  style: Styles.black18,
                                )
                              ]),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty, vertical: Dimens.five),
                        height: Dimens.fifty,
                        width: Dimens.screenWidth,
                        decoration: BoxDecoration(
                            color: ColorsValue.primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _con.changeProfileTab(0);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimens.five,
                                    vertical: Dimens.five),
                                height: Dimens.fourty,
                                width: Dimens.screenWidth / 2 - 45,
                                decoration: BoxDecoration(
                                    color: _con.profileCurrentTab == 0
                                        ? Colors.white
                                        : ColorsValue.primaryColor
                                            .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Plans',
                                  style: Styles.black18,
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _con.changeProfileTab(1);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimens.five,
                                    vertical: Dimens.five),
                                height: Dimens.fourty,
                                width: Dimens.screenWidth / 2 - 45,
                                decoration: BoxDecoration(
                                    color: _con.profileCurrentTab == 1
                                        ? Colors.white
                                        : ColorsValue.primaryColor
                                            .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Spent',
                                  style: Styles.black18,
                                )),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: Dimens.ten,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        planContainer('Starter','3 Minutes \n Voice Call','30'),
                        planContainer('Starter','3 Minutes \n Video Call','50'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        planContainer('25% Discount','10 Minutes \n Voice Call','100'),
                        planContainer('25% Discount','10 Minutes \n Video Call','200'),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Repository().logout();
                        },
                        child: showTitle('Logout')),
                    InkWell(
                        onTap: () {
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

  Widget planContainer(String type,String desc,String price) =>Container(
    height: Dimens.hundred*1.1,
    width: Dimens.screenWidth/2 - 30,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey)
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
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.phone,size: Dimens.twenty,),
              Text(type,style: Styles.white16,)
            ],
          ),
        ),
        SizedBox(height: Dimens.ten,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(desc,style: Styles.black18.copyWith(fontSize: 14),),
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
  );
}
