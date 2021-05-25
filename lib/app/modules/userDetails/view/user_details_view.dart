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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dimens.screenHeight - 23,
                    width: Dimens.screenWidth,
                    child: Stack(
                      children: [
                        SliderCarousel(
                          sliderItem: _con.imageUrl,
                        ),
                        Positioned(
                            bottom: 0,
                            left: Dimens.screenWidth / 2 - 15,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    _con.imageUrl.length,
                                    (index) => Container(
                                          width: _con.currentPage == index
                                              ? 10
                                              : 8.0,
                                          height:  _con.currentPage == index
                                              ? 10
                                              : 8.0,
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
                            child: SizedBox(
                              width: Dimens.screenWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_con.model.name},  ${_con.age}',
                                            style: Styles.white16
                                                .copyWith(fontSize: 20),
                                          ),
                                          Text(
                                              '${_con.model.lang}, ${_con.model.country}',
                                              style: Styles.white16)
                                        ],
                                      ),
                                      Expanded(child: Container(),),
                                      InkWell(
                                        onTap: () {
                                          _con.onClickAudioCall();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorsValue.primaryColor
                                          ),
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
                                              color: ColorsValue.primaryColor
                                          ),
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
                            ))
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
