import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/modules/home/view/local_widget/bottom_navigation.dart';
import 'package:alonecall/app/modules/home/view/page/history.dart';
import 'package:alonecall/app/modules/home/view/page/home_page.dart';
import 'package:alonecall/app/modules/home/view/page/location_page.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
import 'package:alonecall/app/modules/home/view/page/random_call_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_controller) => Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigation(),
            body: IndexedStack(
              index: _controller.currentTab,
              children: [
                HomePage(),
                NearYouMapView(),
                HistoryPage(),
                RandomVideoCallView(),
                ProfileView()
              ],
            ),
          ));
  //StreamBuilder<QuerySnapshot>(
  //       stream: FirebaseFirestore.instance
  //           .collection(FirebaseConstant.user)
  //           .doc(Repository().currentUser())
  //           .collection(FirebaseConstant.call)
  //           .snapshots(),
  //       builder:
  //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
  //         // if (snapshot.connectionState == ConnectionState.waiting) {
  //         //   return Container(
  //         //       color: Colors.white,
  //         //       height: Dimens.screenHeight,
  //         //       width: Dimens.screenWidth,
  //         //       child: const Center(
  //         //         child: CircularProgressIndicator(),
  //         //       ));
  //         // }
  //         if (snapshot.data.docs.isBlank) {
  //           return Scaffold(
  //             backgroundColor: Colors.white,
  //             bottomNavigationBar: BottomNavigation(),
  //             body: IndexedStack(
  //               index: _controller.currentTab,
  //               children: [
  //                 HomePage(),
  //                 NearYouMapView(),
  //                 HistoryPage(),
  //                 RandomVideoCallView(),
  //                 ProfileView()
  //               ],
  //             ),
  //           );
  //         }
  //         var model = CallingModel.fromJson(
  //             snapshot.data.docs[0].data() as Map<String, dynamic>);
  //         if (model.callerUid == Repository().uid) {
  //           return Scaffold(
  //             backgroundColor: Colors.white,
  //             bottomNavigationBar: BottomNavigation(),
  //             body: IndexedStack(
  //               index: _controller.currentTab,
  //               children: [
  //                 HomePage(),
  //                 NearYouMapView(),
  //                 HistoryPage(),
  //                 RandomVideoCallView(),
  //                 ProfileView(),
  //               ],
  //             ),
  //           );
  //         }
  //
  //         return PickUpScreen(
  //           callingModel: model,
  //         );
  //       },
  //     ));
}
