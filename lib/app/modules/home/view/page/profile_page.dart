import 'package:alonecall/app/data/model/history_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/model/withdraw_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
        builder: (_con) => SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: _con.profileCurrentTab == 0 || _con.model.gender == "Male"?const SizedBox():FloatingActionButton.extended(onPressed: (){
                if(_con.addBankModel.accountNumber == null){
                  Get.bottomSheet<dynamic>(Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Add bank account details',
                        style: Styles.boldBlack16,
                      ),
                    ),
                  ),);
                }
                else if(_con.accountBalance <= 100){
                  Get.bottomSheet<dynamic>(Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Minimum amount is 100',
                        style: Styles.boldBlack16,
                      ),
                    ),
                  ),);
                }

                else{
                  _con.withdraw();
                }
              }, label: Text('Withdraw',style: Styles.black12,),elevation: 1,),
              floatingActionButtonLocation: _con.profileCurrentTab == 1?FloatingActionButtonLocation.centerFloat:FloatingActionButtonLocation.endFloat,
              appBar: AppBar(
                title: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimens.twenty, vertical: Dimens.fifteen),
                    height: Dimens.fifty,
                    width: Dimens.screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(15)),
                    child: _con.model.gender == 'Male'
                        ?Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.two),
                          child: InkWell(
                            onTap: () {
                              _con.changeProfileTab(0);
                            },
                            child: Container(
                              height: Dimens.fourty,
                              width: Dimens.screenWidth / 2 - 46,
                              decoration: BoxDecoration(
                                  color: _con.profileCurrentTab == 0
                                      ? Colors.white
                                      : Colors.black12.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                    'Spent',
                                    style: _con.profileCurrentTab == 0
                                        ? Styles.blackBold15
                                        : Styles.grey14,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.five),
                          child: InkWell(
                            onTap: () {
                              _con.changeProfileTab(1);
                            },
                            child: Container(
                              height: Dimens.fourty,
                              width: Dimens.screenWidth / 2 - 46,
                              decoration: BoxDecoration(
                                  color: _con.profileCurrentTab == 1
                                      ? Colors.white
                                      : Colors.black12.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                    'Plans',
                                    style: _con.profileCurrentTab == 1
                                        ? Styles.blackBold15
                                        : Styles.grey14,
                                  )),
                            ),
                          ),
                        )
                      ],
                    )
                        :Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.two),
                          child: InkWell(
                            onTap: () {
                              _con.changeProfileTab(0);
                            },
                            child: Container(
                              height: Dimens.fourty,
                              width: Dimens.screenWidth / 2 - 46,
                              decoration: BoxDecoration(
                                  color: _con.profileCurrentTab == 0
                                      ? Colors.white
                                      : Colors.black12.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Earn',
                                style: _con.profileCurrentTab == 0
                                    ? Styles.blackBold15
                                    : Styles.grey14,
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.five, vertical: Dimens.five),
                          child: InkWell(
                            onTap: () {
                              _con.changeProfileTab(1);
                            },
                            child: Container(
                              height: Dimens.fourty,
                              width: Dimens.screenWidth / 2 - 46,
                              decoration: BoxDecoration(
                                  color: _con.profileCurrentTab == 1
                                      ? Colors.white
                                      : Colors.black12.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Wallets',
                                style: _con.profileCurrentTab == 1
                                    ? Styles.blackBold15
                                    : Styles.grey14,
                              )),
                            ),
                          ),
                        )
                      ],
                    )
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
              body: _con.model.gender == 'Male'
                ? _con.profileCurrentTab == 0 ? spent() : packageDetails(_con)
                :_con.profileCurrentTab == 0 ? earn() : wallets()),
        ),
      );

  Widget packageDetails(HomeController con) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            con.planModelList.length,
            (index) => planContainer(
                con.planModelList[index].title,
                con.planModelList[index].desc,
                '${con.planModelList[index].price}',
                con.model,
                con.planModelList[index].price,
                con.planModelList[index].isVideo,
                con.planModelList[index].discountPrice != 0,discountValue: con.planModelList[index].discountPrice))),
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

  Widget spent() => StreamBuilder(
      stream: Repository().notificationStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            children: List.generate(
                15,
                (index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: Dimens.screenWidth,
                        height: Dimens.fifty,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetConstants.loading, fit: BoxFit.cover),
                        ),
                      ),
                    )),
          );
        }

        if (snapshot.data.docs.isEmpty) {
          return Container(
            height: Dimens.screenHeight,
            width: Dimens.screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/no_data.png'))),
          );
        }
        return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
          var model =
              HistoryModel.fromJson(document.data() as Map<String, dynamic>);
          if (model.receiverUid != Repository().uid &&
              model.callDuration != 0.0) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: Dimens.screenWidth,
                height: Dimens.fifty,
                child: Row(
                  children: [
                    Container(
                      height: Dimens.fifty,
                      width: Dimens.fifty,
                      decoration: BoxDecoration(
                          color: ColorsValue.lightGreyColor,
                          borderRadius: BorderRadius.circular(Dimens.fifty)),
                      child: circularPhoto(
                          imageUrl: model.callerUid == Repository().uid
                              ? model.receiverImage
                              : model.callerImage),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${model.receiverName}',
                                  style: Styles.blackBold16),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
                                child: Icon(
                                  model.isAudio ? Icons.phone : Icons.videocam,
                                  size: Dimens.sixTeen,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.call_made,
                                size: Dimens.sixTeen,
                                color: Colors.green,
                              ),
                              Text(
                                  ' ${DateTime.parse(model.date.toDate().toString())}'
                                      .substring(0, 17),
                                  style: Styles.black12),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('${model.callDuration} sec',
                        style: Styles.blackBold16),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        }).toList());
      });
  Widget planContainer(String type, String desc, String price,
          ProfileModel model, int amount, bool isVideo, bool isDiscount,
          {int discountValue = 0}) =>
      GetBuilder<HomeController>(
        builder: (_con) => InkWell(
          onTap: () {
            var amo = isDiscount ? discountValue : amount;
            _con.onClickPlanOption(!isVideo, amo, amount);
          },
          child: Container(
            height: Dimens.hundred ,
            // width: Dimens.hundred,
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
                    isDiscount
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    price,
                                    style: Styles.black12.copyWith(
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    ' $discountValue',
                                    style:
                                        Styles.black18.copyWith(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Text(
                                'INR ',
                                style: TextStyle(height: 0.5, fontSize: 10),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                price,
                                style: Styles.black18.copyWith(fontSize: 20),
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
        ),
      );


  Widget earn() => StreamBuilder(
      stream: Repository().notificationStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                15,
                    (index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: Dimens.screenWidth,
                    height: Dimens.fifty,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetConstants.loading, fit: BoxFit.cover),
                    ),
                  ),
                )),
          );
        }

        if (snapshot.data.docs.isEmpty) {
          return Container(
            height: Dimens.screenHeight,
            width: Dimens.screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/no_data.png'))),
          );
        }
        return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              var model =
              HistoryModel.fromJson(document.data() as Map<String, dynamic>);
              if (model.callDuration != 0.0) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: Dimens.screenWidth,
                    height: Dimens.fifty,
                    child: Row(
                      children: [
                        Container(
                          height: Dimens.fifty,
                          width: Dimens.fifty,
                          decoration: BoxDecoration(
                              color: ColorsValue.lightGreyColor,
                              borderRadius: BorderRadius.circular(Dimens.fifty)),
                          child: circularPhoto(
                              imageUrl: model.callerUid == Repository().uid
                                  ? model.receiverImage
                                  : model.callerImage),
                        ),
                        SizedBox(
                          width: Dimens.ten,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('${model.receiverName}',
                                      style: Styles.blackBold16),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
                                    child: Icon(
                                      model.isAudio ? Icons.phone : Icons.videocam,
                                      size: Dimens.sixTeen,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.call_made,
                                    size: Dimens.sixTeen,
                                    color: Colors.green,
                                  ),
                                  Text(
                                      ' ${DateTime.parse(model.date.toDate().toString())}'
                                          .substring(0, 17),
                                      style: Styles.black12),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text('${model.callDuration} sec',
                            style: Styles.blackBold16),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            }).toList());
      });

  Widget withdrawHistory() => StreamBuilder(
      stream: Repository().withdrawStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                15,
                    (index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: Dimens.screenWidth,
                    height: Dimens.fifty,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetConstants.loading, fit: BoxFit.cover),
                    ),
                  ),
                )),
          );
        }

        if (snapshot.data.docs.isEmpty) {
          return Container(
            height: Dimens.screenHeight,
            width: Dimens.screenWidth,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/no_data.png'))),
          );
        }

        return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              var model =
              Withdraw.fromJson(document.data() as Map<String, dynamic>);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: Dimens.screenWidth,
                    height: Dimens.fifty,
                    child: Row(
                      children: [
                        Container(
                          height: Dimens.fifty,
                          width: Dimens.fifty,
                          decoration: BoxDecoration(
                              color: ColorsValue.lightGreyColor,
                              image: const DecorationImage(
                                  image: AssetImage('assets/img/logos/logo1.png')),
                              borderRadius: BorderRadius.circular(Dimens.fifty)),
                        ),
                        SizedBox(
                          width: Dimens.ten,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Withdraw',
                                      style: Styles.blackBold16),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      ' ${DateTime.parse(model.date.toDate().toString())}'
                                          .substring(0, 17),
                                      style: Styles.black12),
                                  Text(
                                      '   ${model.status}...',
                                      style: Styles.black12.copyWith(color: Colors.green)),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text('${model.amount} Rs',
                            style: Styles.blackBold16),
                      ],
                    ),
                  ),
                );
              return const SizedBox();
            }).toList());
      });

  Widget wallets()=> GetBuilder<HomeController>(
    builder:(_con)=> ListView(
      children: [
        ListTile(
          title: Text('Balance',style: Styles.black18,),
          trailing: Text('${_con.accountBalance}',style: Styles.blackBold18,),
        ),
        const Divider(),
        withdrawHistory(),
      ],
    ),
  );

  void showBottomSheet() {
    Get.bottomSheet<dynamic>(Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<HomeController>(
        builder:(_con)=> InkWell(
          onTap: () {
            _con.withdraw();
            Get.back<dynamic>();
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Request for money',
                style: Styles.boldBlack16,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
