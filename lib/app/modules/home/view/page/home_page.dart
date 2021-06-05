import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/view/local_widget/home_drawer.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_con) => SafeArea(
            child: Scaffold(
                drawer: drawer(),
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Image.asset(
                    'assets/img/logos/logo.png',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 100,
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            RoutesManagement.goToSearchScreen();
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          RoutesManagement.goToFilterScreen();
                        },
                        icon: const Icon(
                          Icons.filter_list_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    width: Dimens.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _onlineUser(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            Text(
                              'Suggessions',
                              style: Styles.blackBold15.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 15),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _userGridView(_con),
                        )
                      ],
                    ),
                  ),
                )),
          ));

  Widget _onlineUser() => StreamBuilder(
      stream: Repository().onlineUser(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    10,
                    (index) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.5, color: Colors.white),
                                    image: const DecorationImage(
                                        image: AssetConstants.loading,
                                        fit: BoxFit.cover),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 12,
                                width: 70,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetConstants.loading,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ))),
          );
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              var model = ProfileModel.fromJson(
                  document.data() as Map<String, dynamic>);
              return model.uid == Repository().currentUser()
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(right: Dimens.five),
                      child: InkWell(
                        onTap: () {
                          RoutesManagement.goToOthersProfileDetail(model);
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        )
                                      ]),
                                  child: circularPhoto(
                                      imageUrl:
                                          model.profileImageUrl[0] as String),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 13,
                                  child: Container(
                                    height: 13,
                                    width: 13,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        )
                                      ],
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              '${model.name}',
                              style: Styles.black12,
                            )
                          ],
                        ),
                      ),
                    );
            }).toList(),
          ),
        );
      });

  Widget _userGridView(HomeController con) => SizedBox(
        height: 1000,
        child: StreamBuilder(
            stream: Repository().userStream(con.gender(),),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                        10,
                        (index) => Container(
                              height: 250,
                              width: Dimens.screenWidth / 2 - 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5, color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(Dimens.fifteen),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/img/loading.gif'),
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]),
                            )));
              }
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  var model = ProfileModel.fromJson(
                      document.data() as Map<String, dynamic>);
                  var distance = Geolocator.distanceBetween(
                          con.lat, con.long, model.lat, model.long) /
                      1000;
                  var age = DateTime.now().year -
                      int.parse(model.dob.substring(0, 4));

                  if (con.filterModel.initAge <= age &&
                      con.filterModel.lastAge >= age &&
                      con.filterModel.language.contains(model.lang) &&
                      con.filterModel.initDistance <= distance &&
                      con.filterModel.lastDistance > distance
                  ) {
                    return InkWell(
                      onTap: () =>
                          RoutesManagement.goToOthersProfileDetail(model),
                      child: Container(
                        height: 250,
                        width: Dimens.screenWidth / 2 - 100,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.white),
                            borderRadius: BorderRadius.circular(Dimens.fifteen),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimens.fifteen)),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: model.profileImageUrl[0] as String,
                                  placeholder: (context, url) => Container(
                                    height: 250,
                                    width: Dimens.screenWidth / 2 - 100,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/img/loading.gif'),
                                            fit: BoxFit.cover)),
                                  ),
                                  errorWidget: (context, url, dynamic error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Center(
                                    child: Text(
                                      '${model.name}, ${DateTime.now().year - int.parse(model.dob.substring(0, 4))}',
                                      style: Styles.boldWhite16,
                                    ))),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }).toList(),
              );
            }),
      );
}
