import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/search_users/controller/search_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: GetBuilder<SearchController>(
          builder: (_con) => SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  title: Container(
                    height: Dimens.fourty,
                    width: Dimens.hundred * 3,
                    decoration: BoxDecoration(
                        color: ColorsValue.lightGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 2, 10, 2),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => _con.onChangedValue(value),
                        style: Styles.black12.copyWith(fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: Styles.grey14),
                      ),
                    ),
                  ),
                ),
                body: StreamBuilder(
                    stream: Repository().searchUser(_con.item),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                            children: List.generate(
                                4,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        width: Dimens.screenWidth,
                                        height: Dimens.fifty,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetConstants.loading,
                                                fit: BoxFit.cover)),
                                      ),
                                    )));
                      }
                      return ListView(
                          children: snapshot.data.docs.map((DocumentSnapshot document) {
                        var model = ProfileModel.fromJson(
                            document.data() as Map<String, dynamic>);
                        if(model.uid == Repository().uid){
                          return const SizedBox();
                        }
                        if(model.gender == _con.con.model.gender){
                          return const SizedBox();
                        }
                        return InkWell(
                          onTap: () {
                            RoutesManagement.goToOthersProfileDetail(obj: model);
                          },
                          child: Padding(
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
                                        borderRadius: BorderRadius.circular(
                                            Dimens.fifty)),
                                    child: circularPhoto(
                                        imageUrl:
                                            model.profileImageUrl[0] as String),
                                  ),
                                  SizedBox(
                                    width: Dimens.ten,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(model.name,
                                                style: Styles.blackBold16),
                                            Text(
                                                ', ${DateTime.now().year - int.parse(model.dob.substring(0, 4))}',
                                                style: Styles.blackBold16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${model.city}, ',
                                              style: Styles.grey14,
                                            ),
                                            Text(
                                              '${model.country}',
                                              style: Styles.grey14,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList());
                    })),
          ),
        ),
      );
}
