import 'package:flutter/material.dart';

/// This [AppColor] defines a set of colors used throughout the app.
/// A utility class that defines the color palette used throughout the application.
/// Each color is represented as a static constant with a descriptive name.
class AppColor {
  /// Pure white color (#FFFFFF).
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black color (#000000).
  static const Color black = Color(0xFF000000);

  static const Color primaryColor = Color(0xFFC4A662);

  static const Color backgroundColor = Color(0xFF14171F);

  static const Color backColor = Color(0xFF131720);

  static const Color midGray = Color(0xFF6D6D6D);

  /// Vibrant yellow color (#F1E235).
  static const Color vibrantYellow = Color(0xFFF1E235);

  static const Color darkBlueShade = Color(
      0xFF132241); // Name it midnightBlue or darkBlueBackground // Name it midGray or dimGray

  static const Color darkGrayShade = Color(0xFF858585);

  /// Bright red color (#EF3826).
  static const Color red = Color(0xFFEF3826);

  static const Color textFieldBgColor = Color(0xFF2A2E37);

  static const Color navyBlue =
      Color(0xFF000080); // Name it navyBlue or darkNavy

  static const Color orangeColor =
      Color(0xFFFF7618); // Name it vibrantOrange or tangerine

  static const Color mutedBlueShade = Color(0xFF333941);

  static const Color whiteSmoke = Color(0xFFF2F2F2);

  static const Color mutedGold = Color(0xFFC2A466);

  static const Color grayShade = Color(0xFF575757);

  static const Color mutedBlue = Color(0xFF111822);

  static const Color lightGray = Color(0xFFE6E7E8);

  static const Color mutedGray = Color(0xFFBABCBF);

  static const Color customOffWhite = Color(0xFFEDEEF1);

  static const Color mediumGray = Color(0xFFA4A4A4);

  static const Color darkGray = Color(0xFF434343);

  static const Color offWhite = Color(0xFFF9F6EF);

  static const Color darkBlue = Color(0xFF12161F);

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFFFEFDFB), // #FEFDFB
      Color(0xFFFBF8F3), // #FBF8F3
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      surface: backgroundColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'HelveticaNeue',
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}
