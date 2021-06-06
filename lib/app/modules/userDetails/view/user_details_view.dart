import 'package:alonecall/app/modules/userDetails/controller/user_details_controller.dart';
import 'package:alonecall/app/modules/userDetails/view/local_widget/slider.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<UserDetailsController>(
        builder: (_con) => SafeArea(
          child: Scaffold(
            body: SizedBox(
              height: Dimens.screenHeight,
              width: Dimens.screenWidth,
              child: Stack(
                children: [
                  SliderCarousel(
                    sliderItem: _con.imageUrl,
                  ),
                  Positioned(
                      bottom: Dimens.five,
                      left: Dimens.screenWidth / 2 - 15,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              _con.imageUrl.length,
                              (index) => Container(
                                    width: _con.currentPage == index ? 10 : 8.0,
                                    height:
                                        _con.currentPage == index ? 10 : 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _con.currentPage == index
                                          ? ColorsValue.primaryColor
                                          : ColorsValue.primaryColor
                                              .withOpacity(0.5),
                                    ),
                                  )))),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.ten, vertical: Dimens.ten),
                        width: Dimens.screenWidth,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black54],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_con.userModel.name},  ${_con.age}',
                                      style: Styles.white16.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${_con.userModel.lang}, ${_con.userModel.country}',
                                        style: Styles.white16)
                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                InkWell(
                                  onTap: () {
                                    _con.onClickAudioCall();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorsValue.primaryColor),
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimens.ten,
                                ),
                                InkWell(
                                  onTap: () {
                                    _con.onClickVideoCall();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorsValue.primaryColor),
                                    child: const Icon(
                                      Icons.video_call,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _con.shoeBlockUserBottomSheet();
                        }),
                  ),
                  _con.isUserBlockedMe
                      ? Container(
                          height: Dimens.screenHeight,
                          width: Dimens.screenWidth,
                          color: Colors.grey.withOpacity(0.2),
                          child: Column(
                            children: [
                              Container(
                                height: Dimens.hundred * 2,
                                width: Dimens.hundred * 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1, color: Colors.white)),
                                child: Text(
                                  '${_con.userModel.name} Blocked you',
                                  style: Styles.boldWhite18,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      );
}
