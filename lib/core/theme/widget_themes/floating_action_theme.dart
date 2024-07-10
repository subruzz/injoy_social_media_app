import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final class AppFloationActionButtonTheme {
  AppFloationActionButtonTheme._();
  static final AppDarkColor _color = AppDarkColor();

  static final floatingActionButtonTheme = FloatingActionButtonThemeData(
    
    
    shape: RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: AppBorderRadius.extraLarge
    ),
    backgroundColor: _color.buttonBackground,
  );
}
