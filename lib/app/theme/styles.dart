import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alonecall/app/theme/theme.dart';


/// A chunk of styles used in the application.
abstract class Styles {
  static String baseFontFamily = GoogleFonts.openSans().fontFamily;

  // light theme data
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    primaryColor: Colors.lightBlue,
    backgroundColor: ColorsValue.backgroundColor,
    primarySwatch: const MaterialColor(
      ColorsValue.primaryColorHex,
      ColorsValue.primaryColorSwatch,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: baseFontFamily,
    textTheme: TextTheme(
      bodyText1: bodyTextLight1,
      bodyText2: bodyTextLight2,
      subtitle1: subtitleLight1,
      subtitle2: subtitleLight2,
      caption: captionLight,
      button: buttonLight,
      headline1: headlineLight1,
      headline2: headlineLight2,
      headline3: headlineLight3,
      headline4: headlineLight4,
      headline5: headlineLight5,
      headline6: headlineLight6,
    ),
    buttonTheme: buttonThemeData,
  );

  // dark theme data
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    primaryColor: ColorsValue.primaryColor,
    backgroundColor: ColorsValue.backgroundColor,
    primarySwatch: const MaterialColor(
      ColorsValue.primaryColorHex,
      ColorsValue.primaryColorSwatch,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: baseFontFamily,
    textTheme: TextTheme(
      subtitle1: subtitleDark1,
      subtitle2: subtitleDark2,
      bodyText1: bodyTextDark1,
      bodyText2: bodyTextDark2,
      caption: captionDark,
      button: buttonDark,
      headline1: headlineDark1,
      headline2: headlineDark2,
      headline3: headlineDark3,
      headline4: headlineDark4,
      headline5: headlineDark5,
      headline6: headlineDark6,
    ),
    buttonTheme: buttonThemeData,
  );

  static ButtonThemeData buttonThemeData = ButtonThemeData(
      buttonColor: ColorsValue.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimens.fifty,
        ),
      ));

  // Different style used in the application
  // light
  static TextStyle bodyTextLight1 = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle bodyTextLight2 = GoogleFonts.openSans(
    fontSize: Dimens.sixTeen,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle subtitleLight1 = GoogleFonts.openSans(
    color: ColorsValue.titleGreyColor,
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.normal,
  );
  static TextStyle subtitleLight2 = GoogleFonts.openSans(
    color: ColorsValue.titleGreyColor,
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.normal,
  );
  static TextStyle buttonLight = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    fontSize: Dimens.sixTeen,
  );
  static TextStyle captionLight = GoogleFonts.openSans(
    color: ColorsValue.titleGreyColor,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headlineLight6 = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineLight5 = GoogleFonts.openSans(
    fontSize: Dimens.sixTeen,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineLight4 = GoogleFonts.openSans(
    fontSize: Dimens.eighteen,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineLight3 = GoogleFonts.openSans(
    fontSize: Dimens.twenty,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineLight2 = GoogleFonts.openSans(
    fontSize: Dimens.twentyTwo,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineLight1 = GoogleFonts.openSans(
    fontSize: Dimens.twentyFour,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  // dark
  static TextStyle bodyTextDark1 = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.white,
  );
  static TextStyle bodyTextDark2 = GoogleFonts.openSans(
    fontSize: Dimens.sixTeen,
    color: Colors.white,
  );
  static TextStyle subtitleDark1 = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.white,
  );
  static TextStyle subtitleDark2 = GoogleFonts.openSans(
    fontSize: Dimens.twelve,
    color: Colors.white,
  );
  static TextStyle buttonDark = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    fontSize: Dimens.sixTeen,
  );
  static TextStyle captionDark = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.black,
  );
  static TextStyle headlineDark6 = GoogleFonts.openSans(
    fontSize: Dimens.fourteen,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineDark5 = GoogleFonts.openSans(
    fontSize: Dimens.sixTeen,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineDark4 = GoogleFonts.openSans(
    fontSize: Dimens.eighteen,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineDark3 = GoogleFonts.openSans(
    fontSize: Dimens.twenty,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineDark2 = GoogleFonts.openSans(
    fontSize: Dimens.twentyTwo,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headlineDark1 = GoogleFonts.openSans(
    fontSize: Dimens.twentyFour,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle boldAppColor16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.sixTeen,
  );

  static TextStyle boldWhite16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.sixTeen,
  );

  static TextStyle boldWhite18 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.eighteen,
  );

  static TextStyle boldWhite20 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.twenty,
  );

  static TextStyle semiBoldWhite14 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: Dimens.fourteen,
  );

  static TextStyle boldWhite23 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.twentyThree,
  );

  static TextStyle signPainterHS64White = TextStyle(
    color: Colors.white,
    fontSize: Dimens.sixtyFour,
    fontFamily: 'SignPainterRegular',
  );

  static TextStyle signPainterHS64Black = TextStyle(
    color: Colors.black,
    fontSize: Dimens.sixtyFour,
    fontFamily: 'SignPainterRegular',
  );

  static TextStyle white16 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle white7016 = GoogleFonts.openSans(
    color: Colors.white70,
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle lightGrey18 = GoogleFonts.openSans(
    color: ColorsValue.lightGreyColor,
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle white12 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.normal,
  );

  static TextStyle white12Underline = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
  );

  static TextStyle white14 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle blackBold15 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.fifteen,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackBold16 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.bold,
  );

  static TextStyle grey14 = GoogleFonts.openSans(
    color: ColorsValue.greyColor,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle orange16 = GoogleFonts.openSans(
    color: ColorsValue.orangeColor,
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle orange14 = GoogleFonts.openSans(
    color: ColorsValue.orangeColor,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle appColor18 = GoogleFonts.openSans(
    color: ColorsValue.primaryColor,
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle appColor14 = GoogleFonts.openSans(
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle boldBlack36 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.thirtySix,
    fontWeight: FontWeight.bold,
  );

  static TextStyle boldBlack28 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.twentyEight,
    fontWeight: FontWeight.bold,
  );

  static TextStyle boldAppColor36 = GoogleFonts.openSans(
    color: ColorsValue.primaryColor,
    fontSize: Dimens.thirtySix,
    fontWeight: FontWeight.bold,
  );

  static TextStyle black18 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.eighteen,
  );

  static TextStyle blackBold18 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.bold,
  );

  static TextStyle grey16 = GoogleFonts.openSans(
    color: ColorsValue.greyColor,
    fontSize: Dimens.sixTeen,
    fontWeight: FontWeight.normal,
  );

  static TextStyle boldAppColor30 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.thirty,
  );

  static TextStyle boldWhite30 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.thirty,
  );

  static TextStyle boldBlack26 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.twentySix,
  );

  static TextStyle boldBlack22 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.twentyTwo,
  );

  static TextStyle boldBlack16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.sixTeen,
  );

  static TextStyle black12 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.twelve,
    fontWeight: FontWeight.normal,
  );

  static TextStyle appColor10 = GoogleFonts.openSans(
    color: ColorsValue.primaryColor,
    fontSize: Dimens.ten,
    fontWeight: FontWeight.normal,
  );

  static TextStyle white10 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.ten,
    fontWeight: FontWeight.normal,
  );

  static var outlineBorderRadius50 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.fifty,
      ),
    ),
    borderSide: BorderSide.none,
  );

  static var outlineBorderRadius15 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.fifteen,
      ),
    ),
    borderSide: BorderSide.none,
  );
}
