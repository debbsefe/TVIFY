import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/custom_shared_preference.dart';
import 'core/utils/strings.dart';

class CustomTheme extends StateNotifier<ThemeData> {
  final CustomSharedPreference sharedPreference;
  CustomTheme(this.sharedPreference)
      : super(
            //check current theme at app start and pass to the superconstructor
            sharedPreference.retrieveTheme() == DARK_THEME
                ? CustomTheme.darkThemeData
                : CustomTheme.lightThemeData);

  //change the theme by passing themeData and name of the theme
  void changeTheme(ThemeData themeData, String name) {
    if (state != themeData) {
      state = themeData;
      sharedPreference.saveTheme(name);
    }
  }

  static const Color scaffoldLight = Color(0xFFFFF9FA);
  static const Color scaffoldDark = Color(0xFF160105);

  ///PRIMARY COLORS, TINTS AND SHADES
  static const Color primaryColor = Color(0xFF8C1B2F);
  static const Color primaryTint1 = Color(0xFFE5798C);
  static const Color primaryTint2 = Color(0xFFED9FAD);
  static const Color primaryTint3 = Color(0xFFF4C5CE);
  static const Color primaryTint4 = Color(0xFFF8D9DE);
  static const Color primaryTint5 = Color(0xFFFBECEF);
  static const Color primaryShade1 = Color(0xFF2F0910);
  static const Color primaryShade2 = Color(0xFF380B13);
  static const Color primaryShade3 = Color(0xFF410D16);
  static const Color primaryShade4 = Color(0xFF54101C);
  static const Color primaryShade5 = Color(0xFF671422);

  ///secondary colors, tints and shades
  static const Color secondaryColor = Color(0xFF1B8C78);
  static const Color secondaryTint1 = Color(0xFF2CD6B8);
  static const Color secondaryTint2 = Color(0xFF52DEC5);
  static const Color secondaryTint3 = Color(0xFF79E5D2);
  static const Color secondaryTint4 = Color(0xFF8CE9D8);
  static const Color secondaryTint5 = Color(0xFFD9F8F2);
  static const Color secondaryShade1 = Color(0xFF051C18);
  static const Color secondaryShade2 = Color(0xFF092F28);
  static const Color secondaryShade3 = Color(0xFF0D4138);
  static const Color secondaryShade4 = Color(0xFF105448);
  static const Color secondaryShade5 = Color(0xFF146758);

  ///tmc grey colors
  static const Color greyColor1 = Color(0xFF4A1C24);
  static const Color greyColor2 = Color(0xFF806066);
  static const Color greyColor3 = Color(0xFFA58E92);
  static const Color greyColor4 = Color(0xFFB7A4A7);
  static const Color greyColor5 = Color(0xFFB7A4A7);
  static const Color greyColor6 = Color(0xFFC9BBBD);
  static const Color greyColor7 = Color(0xFFDBD2D3);

  ///generic colors
  static const Color successGreen = Color(0xFF1CAE4B);
  static const Color blueColor = Color(0xFF1F8CBD);
  static const Color errorRed = Color(0xFF9B1B33);
  static const Color orangeColor = Color(0xFFC8511B);
  static const Color yellowColor = Color(0xFFC9A717);
  static const Color buttonColor1 = Color(0xFFFBECEF);

  static ThemeData lightThemeData = ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NotoSansKR-Regular',
      scaffoldBackgroundColor: scaffoldLight,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      textTheme: lightTextTheme);

  static ThemeData darkThemeData = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NotoSansKR-Regular',
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: scaffoldDark,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      textTheme: darkTextTheme);

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: paragraph2Bold,
  );

  static TextTheme lightTextTheme = TextTheme(
    bodyText1: paragraph1Bold,
  );

  static const TextStyle paragraph1Bold = TextStyle(
    // bodyText1 -> paragraph1Bold
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: greyColor1,
  );
  static const TextStyle paragraph2Bold = TextStyle(
    // bodyText1 -> paragraph1Bold
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: Colors.white,
  );
}
