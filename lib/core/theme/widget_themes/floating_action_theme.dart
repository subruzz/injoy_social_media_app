import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final class AppFloationActionButtonTheme {
  AppFloationActionButtonTheme._();
  static final AppDarkColor _color = AppDarkColor();

  static final floatingActionButtonTheme = FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppRadius.borderRound,
      ),
    ),
    backgroundColor: _color.buttonBackground,
  );
}
