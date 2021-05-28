import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        builder: (_con) => Scaffold(
          appBar: AppBar(
            title: Text(
              StringConstants.settings,
              style: Styles.boldWhite20,
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
               Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: IconButton(
                  onPressed: (){
                    RoutesManagement.goToSettingsScreen();
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
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
                    InkWell(
                      onTap: () {
                        _con.showEditProfileDialog();
                      },
                      child: Container(
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
                            imageUrl: _con.model.profileImageUrl[0] as String,
                            placeholder: (context, url) => Container(
                              height: Dimens.screenHeight,
                              width: Dimens.screenWidth,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/img/loading.gif'),
                                      fit: BoxFit.cover)),
                            ),
                            errorWidget: (context, url, dynamic error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Text(
                        '${_con.model.name} ${DateTime.now().year - int.parse(_con.model.dob.substring(0, 4))}',
                        style: Styles.blackBold18),
                    SizedBox(
                      height: Dimens.ten,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.five),
                          height: Dimens.thirty,
                          width: Dimens.eighty,
                          decoration: BoxDecoration(
                              color: ColorsValue.lightGreyColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: Dimens.fifteen,
                                ),
                                Text(
                                  '${_con.model.audioCoin * 60} Sec',
                                  style: Styles.black12,
                                )
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.five),
                          height: Dimens.thirty,
                          width: Dimens.eighty,
                          decoration: BoxDecoration(
                              color: ColorsValue.lightGreyColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.videocam,
                                  size: Dimens.fifteen,
                                ),
                                Text(
                                  '${_con.model.coin * 60} Sec',
                                  style: Styles.black12,
                                )
                              ]),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                            vertical: Dimens.fifteen),
                        height: Dimens.fifty,
                        width: Dimens.screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.five,
                                  vertical: Dimens.five),
                              child: InkWell(
                                onTap: () {
                                  _con.changeProfileTab(0);
                                },
                                child: Container(
                                  height: Dimens.fourty,
                                  width: Dimens.screenWidth / 2 - 45,
                                  decoration: BoxDecoration(
                                      color: _con.profileCurrentTab == 0
                                          ? Colors.white
                                          : Colors.black12.withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    'Plans',
                                    style: Styles.blackBold15,
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.five,
                                  vertical: Dimens.five),
                              child: InkWell(
                                onTap: () {
                                  _con.changeProfileTab(1);
                                },
                                child: Container(
                                  height: Dimens.fourty,
                                  width: Dimens.screenWidth / 2 - 45,
                                  decoration: BoxDecoration(
                                      color: _con.profileCurrentTab == 1
                                          ? Colors.white
                                          : Colors.black12.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    'Spent',
                                    style: Styles.blackBold15,
                                  )),
                                ),
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
                        planContainer('Starter', '3 Minutes \n Voice Call',
                            '30', _con.model, 3, false),
                        planContainer('Starter', '3 Minutes \n Video Call',
                            '50', _con.model, 3, true),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        planContainer(
                            '25% Discount',
                            '10 Minutes \n Voice Call',
                            '100',
                            _con.model,
                            10,
                            false),
                        planContainer(
                            '25% Discount',
                            '10 Minutes \n Video Call',
                            '200',
                            _con.model,
                            10,
                            true),
                      ],
                    ),
                   
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

  Widget planContainer(String type, String desc, String price,
          ProfileModel model, int amount, bool isVideo) =>
      InkWell(
        onTap: () {
          RoutesManagement.goToPayment(
            model,
            price,
            <String, dynamic>{
              'type': type,
              'desc': desc,
              'price': price,
              'amount': amount,
              'is_video': isVideo
            },
          );
        },
        child: Container(
          height: Dimens.hundred * 1.1,
          width: Dimens.screenWidth / 2 - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ColorsValue.lightGreyColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: Dimens.hundred * 1.2 + 5,
                decoration: BoxDecoration(
                    color: ColorsValue.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: Styles.boldWhite16.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Dimens.ten,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    desc,
                    style: Styles.black18.copyWith(fontSize: 12),
                  ),
                  Column(
                    children: [
                      Text(
                        price,
                        style: Styles.black18.copyWith(fontSize: 30),
                      ),
                      const Text(
                        'INR',
                        style: TextStyle(height: 0.5, fontSize: 10),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      );
}
