import 'package:alonecall/app/data/model/profile_model.dart';
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
        builder: (_con) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                StringConstants.profile,
                style: Styles.boldWhite20,
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: IconButton(
                    onPressed: () {
                      RoutesManagement.goToSettingsScreen();
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.settings),
                  ),
                ),
              ],
            ),
            body: _con.model.name == null
                ? Container()
                : SingleChildScrollView(
                    child: SizedBox(
                      width: Dimens.screenWidth,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.sixTeen),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Dimens.ten,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  : Colors.black12
                                                      .withOpacity(0.04),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            'Spent',
                                            style: _con.profileCurrentTab == 0?Styles.blackBold15:Styles.grey14,
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
                                                  : Colors.black12
                                                      .withOpacity(0.02),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            'Plans',
                                            style: _con.profileCurrentTab == 1?Styles.blackBold15:Styles.grey14,
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: Dimens.ten,
                            ),

                            _con.profileCurrentTab == 0?Container():packageDetails(_con)
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      );

  Widget packageDetails(HomeController con) =>Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          planContainer(
              'Starter',
              '3 Minutes \n Voice Call',
              '30',
              con.model,
              3,
              false,false),
          planContainer(
              'Starter',
              '3 Minutes \n Video Call',
              '50',
              con.model,
              3,
              true,false),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          planContainer(
              '25% Discount',
              '10 Minutes \n Voice Call',
              '100',
              con.model,
              10,
              false,true,discountValue: 75),
          planContainer(
              '25% Discount',
              '10 Minutes \n Video Call',
              '200',
              con.model,
              10,
              true,true,discountValue: 150),
        ],
      ),
    ],
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
          ProfileModel model, int amount, bool isVideo,bool isDiscount,{int discountValue = 0}) => InkWell(
        onTap: () {
          RoutesManagement.goToPayment(
            model,
            price,
            <String, dynamic>{
              'type': type,
              'desc': desc,
              'price': isDiscount?discountValue:price,
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
                  isDiscount?Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            price,
                            style: Styles.black12.copyWith(fontSize: 15,decoration: TextDecoration.lineThrough),

                          ),
                          Text(
                            ' $discountValue',
                            style: Styles.black18.copyWith(fontSize: 30),
                          ),

                        ],
                      ),
                      const Text(
                        'INR ',
                        style: TextStyle(height: 0.5, fontSize: 10),
                      )
                    ],
                  ):Column(
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
