import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Lato',
    primaryColor: AppColor.bBlue,
    scaffoldBackgroundColor: AppColor.grey,
    appBarTheme: const AppBarTheme(
      elevation: 4.0,
      backgroundColor: AppColor.bBlue,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: AppColor.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColor.darkGrey2,
      ),
      fillColor: AppColor.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: AppColor.darkGrey, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: AppColor.darkGrey, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: AppColor.darkGrey, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: AppColor.error, width: 1.0),
      ),
    ),
  );
}
