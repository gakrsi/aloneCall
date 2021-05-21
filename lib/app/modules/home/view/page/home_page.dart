import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_con) => Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: Dimens.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/logos/logo.png'))),
                  ),
                  _searchAnfFilter(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'online',
                        style: Styles.black18,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          10,
                              (index) => Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5),
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
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Angela,20',
                                style: Styles.black12,
                              )
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Recents',
                        style: Styles.grey16.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _recent(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Suggestions',
                        style: Styles.grey16.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _userGridView(),
                  )
                ],
              ),
            ),
          )));
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

  Widget _recent() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
          10,
              (index) => Container(
            margin: const EdgeInsets.only(right: 16, left: 16),
            height: 150,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)),
          )),
    ),
  );

  Widget _userGridView() => SizedBox(
    height: 500,
    child: StreamBuilder(
      stream: Repository().userStream,
      builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
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
            children: snapshot.data.docs.map((DocumentSnapshot document){
              var model = ProfileModel.fromJson(document.data() as Map<String,dynamic>);
              return model.uid == Repository().currentUser()?Container():InkWell(
                onTap: ()=>RoutesManagement.goToOthersProfileDetail(model),
                child: Container(
                  height: 250,
                  width: Dimens.screenWidth/2 - 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                          left: 70,
                          child: Center(child: Text('${model.name}'))
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
        );
      }
    ),
  );
}
