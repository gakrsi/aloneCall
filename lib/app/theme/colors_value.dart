import 'package:flutter/material.dart';

/// A chunks of colors used
/// in the application
abstract class ColorsValue {
  static const Map<int, Color> primaryColorSwatch = {
    50: Color(0xFFE1F5FE),
    100: Color(0xFFB3E5FC),
    200: Color(0xFF81D4FA),
    300: Color(0xFF4FC3F7),
    400: Color(0xFF29B6F6),
    500: Color(0xFF29B6F7),
    600: Color(0xFF039BE5),
    700: Color(0xFF0288D1),
    800: Color(0xFF0277BD),
    900: Color(0xFF01579B),
  };

  // static const Color primaryColorRgb = Color.fromRGBO(199, 61, 93, 1);
  //
  // static const Color primaryColorLight1Rgbo = Color.fromRGBO(199, 61, 93, .1);

  static const Color primaryColor = Color(primaryColorHex);

  static const Color secondaryColor = Color(secondaryColorHex);

  static const Color thirdColor = Color(thirdColorHex);

  static const Color fourthColor = Color(fourthColorHex);


  static const Color lightPink = Color(lightPinkColorHex);

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

  static const int primaryColorHex = 0xFF26A9E0;

  static const int secondaryColorHex = 0xFF0F4C75;

  static const int thirdColorHex = 0xFF3282B8;

  static const int fourthColorHex = 0xFFBBE1FA;

  static const int white70 = 0x70C73D5D;

  static const int orangeColorHex = 0xFFFDBB5E;

  static const int facebookColorHex = 0xFF4084EF;

  static const int greyColorHex = 0xFF9BA3B7;

  static const int lightGreyColor1Hex = 0xFFE2E2E2;

  static const int lightGreyColorHex = 0xFFE1E1E8;

  static const int titleGreyColorHex = 0xFFB2AEAE;

  static const int lightGreyColor2Hex = 0xFFFAFAFA;

  static const int lightPinkColorHex = 0xFFF2D7D7;

  static const int lightGreyColor3Hex = 0xFFCCCBCB;

  static const int lightGreyColor4Hex = 0xFFDCDEEA;

  static const Color transparent = Color.fromARGB(0, 255, 255, 255);
}
