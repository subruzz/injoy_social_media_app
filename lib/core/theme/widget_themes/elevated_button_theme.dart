import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class AppElevatedButtonTheme {
  static final AppDarkColor _color = AppDarkColor();

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _color.buttonBackground,
      foregroundColor: _color.buttonForground,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.small,
        side: BorderSide(color: _color.secondaryBackground, width: 1.0),
      ),
      minimumSize: Size(50.sp, 50.sp),
      maximumSize: Size(500.sp, 100.sp),
      animationDuration: const Duration(milliseconds: 200),
    ),
  );
}
