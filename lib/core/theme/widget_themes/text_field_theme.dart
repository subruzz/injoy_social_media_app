import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final class AppTextFieldTheme {
  AppTextFieldTheme._();
  static final AppDarkColor _color = AppDarkColor();

  static InputDecorationTheme textFieldTheme = InputDecorationTheme(

    prefixIconColor: _color.iconSoftColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    
    errorStyle: TextStyle(
      color: _color.primaryTextSoft,
    ),
    counterStyle: TextStyle(
      color: _color.primaryTextBlur,
    ),
    hintStyle: TextStyle(color: _color.secondaryText, fontSize: 12.sp),
  );
}
