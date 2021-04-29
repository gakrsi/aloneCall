import 'package:flutter/material.dart';

/// A chunks of colors used
/// in the application
abstract class ColorsValue {
  static const Map<int, Color> primaryColorSwatch = {
    50: Color.fromRGBO(199, 61, 93, .1),
    100: Color.fromRGBO(199, 61, 93, .2),
    200: Color.fromRGBO(199, 61, 93, .3),
    300: Color.fromRGBO(199, 61, 93, .4),
    400: Color.fromRGBO(199, 61, 93, .5),
    500: Color.fromRGBO(199, 61, 93, .6),
    600: Color.fromRGBO(199, 61, 93, .7),
    700: Color.fromRGBO(199, 61, 93, .8),
    800: Color.fromRGBO(199, 61, 93, .9),
    900: Color.fromRGBO(199, 61, 93, 1.0),
  };

  static const Color primaryColorRgb = Color.fromRGBO(199, 61, 93, 1);

  static const Color primaryColorLight1Rgbo = Color.fromRGBO(199, 61, 93, .1);

  static const Color primaryColor = Colors.deepPurpleAccent;//Color(primaryColorHex);

  static const Color facebookColor = Color(
    facebookColorHex,
  );

  static const Color orangeColor = Color(
    orangeColorHex,
  );

  static const Color greyColor = Color(
    greyColorHex,
  );

  static const Color lightGreyColor = Color(
    lightGreyColorHex,
  );

  static const Color lightGreyColor1 = Color(
    lightGreyColor1Hex,
  );

  static const Color lightGreyColor2 = Color(
    lightGreyColor2Hex,
  );

  static const Color lightGreyColor3 = Color(
    lightGreyColor3Hex,
  );

  static const Color lightGreyColor4 = Color(
    lightGreyColor4Hex,
  );

  static const Color titleGreyColor = Color(
    titleGreyColorHex,
  );

  static Color backgroundColor = Colors.white;

  static const int primaryColorHex = 0xFF40826D;

  static const int white70 = 0x70C73D5D;

  static const int orangeColorHex = 0xFFFDBB5E;

  static const int facebookColorHex = 0xFF4084EF;

  static const int greyColorHex = 0xFF9BA3B7;

  static const int lightGreyColor1Hex = 0xFFE2E2E2;

  static const int lightGreyColorHex = 0xFFE1E1E8;

  static const int titleGreyColorHex = 0xFFB2AEAE;

  static const int lightGreyColor2Hex = 0xFFFAFAFA;

  static const int lightGreyColor3Hex = 0xFFCCCBCB;

  static const int lightGreyColor4Hex = 0xFFDCDEEA;

  static const Color transparent = Color.fromARGB(0, 255, 255, 255);
}
