import 'package:alonecall/app/modules/userDetails/controller/user_details_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<UserDetailsController>(
        builder: (_con) => SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorsValue.primaryColor,
              onPressed: () {
                _con.onClickVideoCall();
              },
              child: const Icon(
                Icons.video_call,
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Dimens.screenWidth,
                    width: Dimens.screenWidth,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/full_image.png'),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _con.model.name,
                          style: Styles.boldBlack22,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
