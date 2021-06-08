import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/modules/home/view/local_widget/bottom_navigation.dart';
import 'package:alonecall/app/modules/home/view/page/female_profile_view.dart';
import 'package:alonecall/app/modules/home/view/page/history.dart';
import 'package:alonecall/app/modules/home/view/page/home_page.dart';
import 'package:alonecall/app/modules/home/view/page/location_page.dart';
import 'package:alonecall/app/modules/home/view/page/notification_page.dart';
import 'package:alonecall/app/modules/home/view/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_controller) => SafeArea(
        child: Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNavigation(),
              body: IndexedStack(
                index: _controller.currentTab,
                children: [
                  HomePage(),
                  NearYouMapView(),
                  HistoryPage(),
                  NotificationPage(),
                  _controller.model.gender != 'Male'
                      ? ProfileView()
                      : FemaleProfileView()
                ],
              ),
            ),
      ));

}
