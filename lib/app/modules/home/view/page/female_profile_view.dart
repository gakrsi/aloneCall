import 'package:alonecall/app/data/model/history_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FemaleProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.wallet,
          style: Styles.boldWhite20,
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                showBottomSheet();
              }),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder:(_con)=> ListView(
          children: [
            ListTile(
              title: Text('Balance',style: Styles.black18,),
              trailing: Text('${_con.accountBalance}',style: Styles.blackBold18,),
            ),
            const Divider(),
            earn()
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

  void showBottomSheet() {
    Get.bottomSheet<dynamic>(Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<HomeController>(
        builder:(_con)=> InkWell(
          onTap: () {
            // _con.withdraw(amount)
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
