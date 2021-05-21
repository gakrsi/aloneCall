import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// A bottom navigation widget which will be used on the home page
/// for showing multiple navigation points.
class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
    builder: (_controller) => Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 0.1,color: Colors.grey))
      ),
      child: BottomNavigationBar(
          elevation: 0,
          selectedLabelStyle: Styles.appColor14,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: Styles.grey14.copyWith(fontSize: 11),
          currentIndex: _controller.currentTab,
          onTap: (index) {
            _controller.changeTab(index);
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: ColorsValue.primaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: _controller.tab
      ),
    ),
  );
}
