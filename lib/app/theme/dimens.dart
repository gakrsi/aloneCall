import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Contains the dimensions and padding used
/// all over the application.
abstract class Dimens {
  static double screenHeight = Get.mediaQuery.size.height;
  static double screenWidth = Get.mediaQuery.size.width;
  static double sixTeen = 16.nsp;
  static double nineteen = 19.nsp;
  static double three = 3.nsp;
  static double eight = 8.nsp;
  static double zero = 0.nsp;
  static double eighteen = 18.nsp;
  static double thirtySix = 36.nsp;
  static double twentyEight = 28.nsp;
  static double six = 6.nsp;
  static double sixty = 60.nsp;
  static double twentyTwo = 22.nsp;
  static double fifty = 50.nsp;
  static double one = 1.nsp;
  static double twentyFour = 24.nsp;
  static double twentyThree = 23.nsp;
  static double thirtyNine = 39.nsp;
  static double twentyFive = 25.nsp;
  static double thirty = 30.nsp;
  static double eighty = 80.nsp;
  static double pointFive = 0.5.nsp;
  static double twentySix = 26.nsp;
  static double sixtyFour = 64.nsp;
  static double twenty = 20.nsp;
  static double ten = 10.nsp;
  static double five = 5.nsp;
  static double fifteen = 15.nsp;
  static double four = 4.nsp;
  static double two = 2.nsp;
  static double fourteen = 14.nsp;
  static double twelve = 12.nsp;
  static double thirtyTwo = 32.nsp;
  static double thirtyFive = 35.nsp;
  static double seventy = 70.nsp;
  static double fourty = 40.nsp;
  static double thirtyFour = 34.nsp;
  static double seven = 7.nsp;
  static double ninetyEight = 98.nsp;
  static double ninetyFive = 95.nsp;
  static double fiftyFive = 55.nsp;
  static double fiftyFour = 54.nsp;
  static double hundred = 100.nsp;
  static double oneHundredFifty = 150.nsp;
  static double oneHundredTwenty = 120.nsp;
  static double seventyEight = 78.nsp;

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;

  static EdgeInsets edgeInsets24_0_24_10 = EdgeInsets.fromLTRB(
    twentyFour,
    zero,
    twentyFour,
    ten,
  );
  static EdgeInsets edgeInsets15_10_15_10 = EdgeInsets.fromLTRB(
    fifteen,
    ten,
    fifteen,
    ten,
  );
  static EdgeInsets edgeInsets20_0_0_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets0_15_0_15 = EdgeInsets.fromLTRB(
    zero,
    fifteen,
    zero,
    fifteen,
  );
  static EdgeInsets edgeInsets20_14P_0_0 = EdgeInsets.fromLTRB(
    twenty,
    percentHeight(0.14),
    zero,
    zero,
  );
  static EdgeInsets edgeInsets20_10P_20_20 = EdgeInsets.fromLTRB(
    twenty,
    percentHeight(0.10),
    twenty,
    twenty,
  );
  static EdgeInsets edgeInsets20_10_20_10 = EdgeInsets.fromLTRB(
    twenty,
    ten,
    twenty,
    ten,
  );
  static EdgeInsets edgeInsets0_80_0_100 = EdgeInsets.fromLTRB(
    zero,
    eighty,
    zero,
    hundred,
  );
  static EdgeInsets edgeInsets50_10_50_10 = EdgeInsets.fromLTRB(
    fifty,
    ten,
    fifty,
    ten,
  );
  static EdgeInsets edgeInsets25_20_25_20 = EdgeInsets.fromLTRB(
    twentyFive,
    twenty,
    twentyFive,
    twenty,
  );
  static EdgeInsets edgeInsets15_0_15_20 = EdgeInsets.fromLTRB(
    fifteen,
    zero,
    fifteen,
    twenty,
  );
  static EdgeInsets edgeInsets0_0_10_0 = EdgeInsets.fromLTRB(
    zero,
    zero,
    ten,
    zero,
  );
  static EdgeInsets edgeInsets24_0_24_0 = EdgeInsets.fromLTRB(
    twentyFour,
    zero,
    twentyFour,
    zero,
  );
  static EdgeInsets edgeInsets0_10_0_0 = EdgeInsets.fromLTRB(
    zero,
    ten,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets0_0_0_15 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    fifteen,
  );
  static EdgeInsets edgeInsets20_0_20_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    twenty,
    zero,
  );
  static EdgeInsets edgeInsets20_0_5_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    five,
    zero,
  );
  static EdgeInsets edgeInsets20_0_20_20 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    twenty,
    twenty,
  );
  static EdgeInsets edgeInsets0_5_0_0 = EdgeInsets.fromLTRB(
    zero,
    five,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets10_5_10_5 = EdgeInsets.fromLTRB(
    ten,
    five,
    ten,
    five,
  );
  static EdgeInsets edgeInsets20_120_20_50 = EdgeInsets.fromLTRB(
    twenty,
    oneHundredTwenty,
    twenty,
    fifty,
  );
  static EdgeInsets edgeInsets24_0_40_34 = EdgeInsets.fromLTRB(
    fourty,
    zero,
    fourty,
    thirtyFour,
  );
  static EdgeInsets edgeInsets0_30_0_50 = EdgeInsets.fromLTRB(
    zero,
    thirty,
    zero,
    fifty,
  );
  static EdgeInsets edgeInsets0_15_0_50 = EdgeInsets.fromLTRB(
    zero,
    fifteen,
    zero,
    fifty,
  );
  static EdgeInsets edgeInsets30_0_30_30 = EdgeInsets.fromLTRB(
    thirty,
    zero,
    thirty,
    thirty,
  );
  static EdgeInsets edgeInsets40_0_40_0 = EdgeInsets.fromLTRB(
    fourty,
    zero,
    fourty,
    zero,
  );
  static EdgeInsets edgeInsets50_0_50_0 = EdgeInsets.fromLTRB(
    fifty,
    zero,
    fifty,
    zero,
  );
  static EdgeInsets edgeInsets0_54_0_0 = EdgeInsets.fromLTRB(
    zero,
    fiftyFour,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets50_30_50_0 = EdgeInsets.fromLTRB(
    fifty,
    thirty,
    fifty,
    zero,
  );
  static EdgeInsets edgeInsets10_0_10_5 = EdgeInsets.fromLTRB(
    ten,
    zero,
    ten,
    five,
  );
  static EdgeInsets edgeInsets10_0_10_0 = EdgeInsets.fromLTRB(
    ten,
    zero,
    ten,
    zero,
  );
  static EdgeInsets edgeInsets0_10P_0_10 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.10),
    zero,
    five,
  );
  static EdgeInsets edgeInsets0_0_0_20 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    twenty,
  );
  static EdgeInsets edgeInsets0_0_0_80 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets0_12P_0_80 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.12),
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets0_14P_0_80 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.14),
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets15 = EdgeInsets.all(
    fifteen,
  );
  static EdgeInsets edgeInsets2 = EdgeInsets.all(
    two,
  );
  static EdgeInsets edgeInsets5 = EdgeInsets.all(
    five,
  );
  static EdgeInsets edgeInsetsTopTwelvePercent = EdgeInsets.only(
    top: percentHeight(0.12),
  );
  static EdgeInsets edgeInsets10 = EdgeInsets.all(
    ten,
  );
  static EdgeInsets edgeInsets40 = EdgeInsets.all(
    fourty,
  );
  static EdgeInsets edgeInsets16 = EdgeInsets.all(
    sixTeen,
  );
  static EdgeInsets edgeInsets20 = EdgeInsets.all(
    twenty,
  );

  static SizedBox boxHeight10 = SizedBox(
    height: ten,
  );
  static SizedBox boxHeight5 = SizedBox(
    height: five,
  );
  static SizedBox boxHeight1 = SizedBox(
    height: one,
  );
  static SizedBox boxHeight3 = SizedBox(
    height: three,
  );
  static SizedBox boxHeight32 = SizedBox(
    height: thirtyTwo,
  );
  static SizedBox boxHeight35 = SizedBox(
    height: thirtyFive,
  );
  static SizedBox boxHeight16 = SizedBox(
    height: sixTeen,
  );
  static SizedBox boxHeight30 = SizedBox(
    height: thirty,
  );
  static SizedBox boxHeight40 = SizedBox(
    height: fourty,
  );
  static SizedBox boxWidth12 = SizedBox(
    width: twelve,
  );
  static SizedBox boxWidth10 = SizedBox(
    width: ten,
  );
  static SizedBox boxWidth20 = SizedBox(
    width: twenty,
  );
  static SizedBox boxHeight20 = SizedBox(
    height: twenty,
  );
  static SizedBox boxHeight25 = SizedBox(
    height: twentyFive,
  );
  static SizedBox boxHeight15 = SizedBox(
    height: fifteen,
  );
  static SizedBox boxWidth15 = SizedBox(
    width: fifteen,
  );
  static SizedBox boxHeight26 = SizedBox(
    height: twentySix,
  );
  static SizedBox box0 = SizedBox(
    height: zero,
    width: zero,
  );
}
