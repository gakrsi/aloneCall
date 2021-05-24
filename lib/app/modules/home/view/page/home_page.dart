import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_con) => SafeArea(
        child: Scaffold(
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
              leading: const Icon(Icons.camera_alt),
              actions: [
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.filter_list_alt,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: GestureDetector(
              onPanUpdate: (value){
                if(value.delta.dx > 0){
                  RoutesManagement.goToOthersRandomCallView();
                }
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  width: Dimens.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
                        height: 80,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/logos/logo.png'))),
                      ),*/
                      //_searchAnfFilter(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        children: [
                          // const SizedBox(
                          //   width: 16,
                          // ),
                          // Container(
                          //   height: 10,
                          //   width: 10,
                          //   decoration: const BoxDecoration(
                          //       color: Colors.green, shape: BoxShape.circle),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          // Text(
                          //   'online',
                          //   style: Styles.black18,
                          // )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      _onlineUser(),
                      /*SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              10,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          // margin: const EdgeInsets.symmetric(
                                          //     horizontal: 5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1.5, color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Angela,20',
                                          style: Styles.black12,
                                        )
                                      ],
                                    ),
                                  )),
                        ),
                      ),*/
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
                        child: _userGridView(),
                      )
                    ],
                  ),
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
          return const Text('Loading');
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1.5, color: Colors.white),
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
                          Text(
                            '${model.name}',
                            style: Styles.black12,
                          )
                        ],
                      ),
                  );
            }).toList(),
          ),
        );
      });
  Widget _searchAnfFilter() => Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Container(
            height: 55,
            width: Dimens.screenWidth - 70,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // controller: controller,
                style: Styles.black18,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Here',
                    hintStyle: Styles.grey16),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.filter_list_outlined), onPressed: () {})
        ],
      );

  Widget _userGridView() => SizedBox(
        height: 500,
        child: StreamBuilder(
            stream: Repository().userStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  var model = ProfileModel.fromJson(
                      document.data() as Map<String, dynamic>);
                  return model.uid == Repository().currentUser()
                      ? Container()
                      : InkWell(
                          onTap: () =>
                              RoutesManagement.goToOthersProfileDetail(model),
                          child: Container(
                            height: 250,
                            width: Dimens.screenWidth / 2 - 100,
                            decoration: BoxDecoration(

                                border:
                                    Border.all(width: 1.5, color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
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
                                Container(
                                  height: 250,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: model.profileImageUrl[0] as String,
                                    placeholder: (context, url) =>Container(
                                      height: 250,
                                      width: Dimens.screenWidth / 2 - 100,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/img/loading.gif'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    errorWidget: (context, url, dynamic error) => const Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                    child:
                                        Center(child: Text('${model.name}'))),
                              ],
                            ),
                          ),
                        );
                }).toList(),
              );
            }),
      );
}
