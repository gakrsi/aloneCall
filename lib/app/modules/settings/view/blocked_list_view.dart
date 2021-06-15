import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/modules/settings/controller/setting_controller.dart';
import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                StringConstants.blockedList,
                style: Styles.boldWhite20,
              ),
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: StreamBuilder(
                stream: Repository().blockUserStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(padding: const EdgeInsets.all(12.0),
                    child:  Container(
                        width: Dimens.screenWidth,
                        height: Dimens.fifty,
                      decoration: const BoxDecoration(
                        image:DecorationImage(
                          image:  AssetConstants.loading
                        )
                      ),
                    ),);
                  }
                  return ListView(
                    children:   snapshot.data.docs.map((DocumentSnapshot document) {
                      var model = ProfileModel.fromJson(
                          document.data() as Map<String, dynamic>);
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
                                    borderRadius:
                                    BorderRadius.circular(Dimens.fifty)),
                                child: circularPhoto(imageUrl: model.profileImageUrl[0] as String),
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
                                        Text(model.name,
                                            style: Styles.blackBold16),
                                        Text(', ${DateTime.now().year - int.parse(model.dob.substring(0, 4))}', style: Styles.blackBold16),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${model.lang}, ',
                                          style: Styles.grey14,
                                        ),
                                        Text(
                                          '${model.country}, ',
                                          style: Styles.grey14,
                                        ),
                                        Text(
                                          'Country',
                                          style: Styles.grey14,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GetBuilder<SettingController>(
                                builder:(_con)=> IconButton(
                                    icon: const Icon(Icons.more_vert),
                                    onPressed: () {
                                      _con.shoeBlockUserBottomSheet(model);
                                      // Get.find<HomeController>().
                                    }),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList()
                  );
                })),
      );
}
