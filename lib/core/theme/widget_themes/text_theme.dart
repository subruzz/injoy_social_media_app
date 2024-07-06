import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final class AppTextTheme {
  AppTextTheme._();
  static final AppDarkColor _color = AppDarkColor();

  static TextTheme appTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 30.sp,
      letterSpacing: 1.5,
    ),
    displayMedium: TextStyle(
        color: _color.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 25.sp,
        height: 1.5),
    displaySmall: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 23.sp,
    ),

    //mainly used in appbar text
    headlineLarge: TextStyle(
      letterSpacing: 1.2,
      color: _color.primaryText,
      fontWeight: FontWeight.bold,
      fontSize: 22.sp,
    ),
    headlineMedium: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
    ),
    headlineSmall: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 19.sp,
    ),
    titleLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 18.sp,
    ),
    titleMedium: TextStyle(
      color: _color.primaryText,
      fontSize: 17.sp,
    ),
    titleSmall: TextStyle(
        color: _color.primaryText,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        color: _color.primaryText,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: _color.secondaryPrimaryText, fontSize: 15.sp),
    labelSmall: TextStyle(
        color: _color.primaryText,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 14.sp,
    ),
    bodyMedium: TextStyle(
      color: _color.primaryText,
      fontSize: 13.sp,
    ),
    bodySmall: TextStyle(
      color: _color.primaryText,
      fontSize: 12.sp,
    ),
  );
}
