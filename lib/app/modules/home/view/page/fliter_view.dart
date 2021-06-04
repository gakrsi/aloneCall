import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/primary_button.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (_controller) => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  StringConstants.filter,
                  style: Styles.boldWhite20,
                ),
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.sixTeen),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age',
                        style: Styles.black18,
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Container(
                        height: 130,
                        padding: EdgeInsets.all(Dimens.sixTeen),
                        width: Dimens.screenWidth,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ColorsValue.primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Between ${_controller.filterModel.initAge} and ${_controller.filterModel.lastAge}',
                              style: Styles.black18,
                            ),
                            _slider(_controller.filterModel.initAge,
                                _controller.filterModel.lastAge,_controller),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Text(
                        'Location',
                        style: Styles.black18,
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Container(
                        height: 130,
                        padding: EdgeInsets.all(Dimens.sixTeen),
                        width: Dimens.screenWidth,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ColorsValue.primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Up to ${_controller.filterModel.lastDistance} kilometres away',
                              style: Styles.black18,
                            ),
                            _distanceSlider(_controller.filterModel.initDistance,
                                _controller.filterModel.lastDistance,_controller),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Text(
                        'Language',
                        style: Styles.black18,
                      ),
                      SizedBox(
                        height: Dimens.ten,
                      ),
                      Container(
                        height: 450,
                        width: Dimens.screenWidth,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ColorsValue.primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: List.generate(
                                  _controller.languageList.length,
                                  (index) => InkWell(
                                        onTap: () {
                                          _controller.addLanguageToList(_controller.languageList[index]);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.4)),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: _controller
                                                      .filterModel.language
                                                      .contains(_controller
                                                          .languageList[index])
                                                  ? ColorsValue.primaryColor
                                                  : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                )
                                              ]),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8),
                                              child: Text(
                                                _controller.languageList[index],
                                                style: Styles.grey16.copyWith(
                                                    color: _controller
                                                            .filterModel
                                                            .language
                                                            .contains(_controller
                                                                    .languageList[
                                                                index])
                                                        ? Colors.white
                                                        : Colors.grey),
                                              )),
                                        ),
                                      ))),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      InkWell(
                          onTap: () {
                            Utility.showLoadingDialog();
                            Repository().updateFilter(_controller.filterModel).whenComplete(Utility.closeDialog);
                          },
                          child: PrimaryButton(
                            title: StringConstants.apply,
                            disable: true,
                          )),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));

  Widget _slider(int init, int last,HomeController con) => FlutterSlider(
        values: [
          init.toDouble(),
          last.toDouble(),
        ],
        rangeSlider: true,
        max: 100, //last.toDouble(),
        min: 0, //init.toDouble(),
        touchSize: Dimens.twentyTwo,
        handler: FlutterSliderHandler(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: ColorsValue.primaryColor)),
            child: const Center(
              child: Icon(
                Icons.pause,
                color: ColorsValue.primaryColor,
              ),
            ),
          ),
        ),
        rightHandler: FlutterSliderHandler(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: ColorsValue.primaryColor)),
            child: const Center(
              child: Icon(Icons.pause, color: ColorsValue.primaryColor),
            ),
          ),
        ),
        trackBar: FlutterSliderTrackBar(
          activeTrackBarHeight: Dimens.seven,
          inactiveTrackBarHeight: Dimens.seven,
          inactiveTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
            border: Border.all(width: 3, color: Colors.grey),
          ),
          activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorsValue.primaryColor,
          ),
        ),
    onDragging: ( handlerIndex, dynamic lowerValue,  dynamic upperValue) {
          print(upperValue);
          con.updateAgeSlider(lowerValue, upperValue);
    },
      );

  Widget _distanceSlider(int init, int last,HomeController con) => FlutterSlider(
    values: [
      init.toDouble(),
      last.toDouble(),
    ],
    rangeSlider: true,
    max: 100, //last.toDouble(),
    min: 0, //init.toDouble(),
    touchSize: Dimens.twentyTwo,
    handler: FlutterSliderHandler(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: ColorsValue.primaryColor)),
        child: const Center(
          child: Icon(
            Icons.pause,
            color: ColorsValue.primaryColor,
          ),
        ),
      ),
    ),
    rightHandler: FlutterSliderHandler(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: ColorsValue.primaryColor)),
        child: const Center(
          child: Icon(Icons.pause, color: ColorsValue.primaryColor),
        ),
      ),
    ),
    trackBar: FlutterSliderTrackBar(
      activeTrackBarHeight: Dimens.seven,
      inactiveTrackBarHeight: Dimens.seven,
      inactiveTrackBar: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
        border: Border.all(width: 3, color: Colors.grey),
      ),
      activeTrackBar: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorsValue.primaryColor,
      ),
    ),
    onDragging: ( handlerIndex, dynamic lowerValue,  dynamic upperValue) {
      con.updateDistanceSlider(lowerValue, upperValue);
    },
  );
}
