import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final class AppTextFieldTheme {
  AppTextFieldTheme._();
  static final AppDarkColor _color = AppDarkColor();
  static final _outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: _color.primaryText.withOpacity(0.3)),
      borderRadius: AppBorderRadius.small);
  static InputDecorationTheme textFieldTheme = InputDecorationTheme(
    filled: true,
    prefixIconColor: _color.iconSoftColor,
    fillColor: _color.fillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: _outlineInputBorder,
    errorBorder: _outlineInputBorder,
    focusedErrorBorder: _outlineInputBorder,
    errorStyle: TextStyle(
      color: _color.primaryTextSoft,
    ),
    counterStyle: TextStyle(
      color: _color.primaryTextBlur,
    ),
    hintStyle: TextStyle(color: _color.secondaryText, fontSize: 12.sp),
  );
}
