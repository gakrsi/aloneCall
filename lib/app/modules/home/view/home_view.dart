import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/theme.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_con) => Scaffold(
            body: _con.controller.value.isInitialized
                ? SizedBox(
                    height: Dimens.screenHeight,
                    width: Dimens.screenWidth,
                    child: CameraPreview(_con.controller))
                : Container(),
          ));
}
