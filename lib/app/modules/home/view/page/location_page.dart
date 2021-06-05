import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NearYouMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: GetBuilder<HomeController>(
      builder:(_controller)=> Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('Near You',style: Styles.white16.copyWith(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              body: StreamBuilder(
                  stream: Repository().nearYou(_controller.model.city),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                          children: List.generate(
                              4, (index) => Padding(
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
                          var distance = Geolocator.distanceBetween(_controller.lat,_controller.long,model.lat,model.long)/1000;
                          var counter = 0;
                          // if(counter == 0){
                          //   return Container(
                          //     height: Dimens.screenHeight,
                          //     width: Dimens.screenWidth,
                          //     decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //         image: AssetImage('assets/img/no_data.png')
                          //       )
                          //     ),
                          //   );
                          // }
                          // if(model.uid == Repository().uid || distance <= 10000 || _controller.model.gender == model.gender){
                          //   return const SizedBox();
                          // }
                          counter ++;
                          return InkWell(
                            onTap: () {
                              RoutesManagement.goToOthersProfileDetail(model);
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
                                                '${model.country}, ',
                                                style: Styles.grey14,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    const Spacer(),
                                    Text('${distance.ceilToDouble()} Km')
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList());
                  })
      ),
    )
  );
}
