import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const Color scaffoldLight = Color(0xFFFFF9FA);
  static const Color scaffoldDark = Colors.black;

  ///PRIMARY COLORS, TINTS AND SHADES
  static const Color primaryColor300 = Color(0xFFFFDCD2);
  static const Color primaryColor = Color(0xFFFF8663);
  static const Color primaryTint2 = Color(0xFFED9FAD);

  static const Color primaryTint4 = Color(0xFFF8D9DE);
  static const Color primaryTint5 = Color(0xFFFBECEF);

  ///secondary colors, tints and shades
  static const Color secondaryColor = Color(0xFF1B8C78);

  ///tmc grey colors
  static const Color grey100 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFBABABA);
  static const Color greyColor2 = Color(0xFF806066);
  static const Color greyColor3 = Color(0xFFA58E92);
  static const Color greyColor7 = Color(0xFFDBD2D3);

  ///generic colors
  static const Color successGreen = Color(0xFF1CAE4B);
  static const Color blueColor = Color(0xFF1F8CBD);
  static const Color errorRed = Color(0xFF9B1B33);
  static const Color orangeColor = Color(0xFFC8511B);
  static const Color yellowColor = Color(0xFFC9A717);
  static const Color buttonColor1 = Color(0xFFFBECEF);
  static const Color yellowStar = Color(0xFFF3CD2A);
  static const Color nonPhotoBlue = Color(0xFF98d9eb);
  static const Color mediumChampagne = Color(0xFFEDE6AD);

  static ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: bodyTextLight,
      elevation: 0,
      backgroundColor: scaffoldLight,
      iconTheme: IconThemeData(color: greyColor2),
    ),
    textTheme: GoogleFonts.dmMonoTextTheme(lightTextTheme),
  );

  static ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
    ),
    textTheme: GoogleFonts.dmMonoTextTheme(darkTextTheme),
  );

  static TextTheme darkTextTheme = const TextTheme(
    titleMedium: subtitleRegDark,
    titleSmall: subtitle,
    headlineMedium: headline4Dark,
    titleLarge: headline6Dark,
    bodySmall: captionDark,
    bodyLarge: bodyTextDark,
    bodyMedium: bodyText2,
  );

  static TextTheme lightTextTheme = const TextTheme(
    titleMedium: subtitleRegLight,
    titleSmall: subtitle,
    headlineMedium: headline4Light,
    titleLarge: headline6Light,
    bodySmall: captionLight,
    bodyLarge: bodyTextLight,
    bodyMedium: bodyText2,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 12,
  );
  static const TextStyle bodyTextLight = TextStyle(
    fontSize: 16,
  );

  static const TextStyle bodyTextDark = TextStyle(
    fontSize: 16,
  );

  static const TextStyle headline4Light = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle headline4Dark = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const TextStyle headline6Light = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static const TextStyle headline6Dark = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static const TextStyle captionLight = TextStyle(
    fontSize: 10,
  );

  static const TextStyle captionDark = TextStyle(
    fontSize: 10,
  );
  static const TextStyle subtitle = TextStyle(
    // subtitle -> subtitleLight
    fontSize: 10,
    color: mediumChampagne,
  );

  static const TextStyle subtitleRegLight = TextStyle(
    // subtitle1 -> subtitleRegular
    fontSize: 12,
  );

  static const TextStyle subtitleRegDark = TextStyle(
    // subtitle1 -> subtitleRegular
    fontSize: 12,
  );
}
