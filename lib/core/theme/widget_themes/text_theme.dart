

import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

import '../../utils/responsive/responsive_text.dart';

final class AppTextTheme {
  AppTextTheme._();
  static final AppDarkColor _color = AppDarkColor();

  static TextTheme appTextTheme = TextTheme(
    displayLarge: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 30,
      letterSpacing: 1.5,
    ),
    displayMedium: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 25,
      height: 1.5,
    ),
    displaySmall: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 23,
    ),
    headlineLarge: TextStyle(
      letterSpacing: 1.2,
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 21,
    ),
    headlineMedium: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 19,
    ),
    titleLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: _color.primaryText,
      fontSize: 17,
    ),
    titleSmall: TextStyle(
      color: _color.primaryText,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: _color.primaryText,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: _color.primaryText,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
        color: _color.secondaryText,
        fontSize: 13,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
      color: _color.primaryText,
      fontSize: 12,
    ),
  );

  static TextTheme getResponsiveTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.displayLarge!),
      displayMedium: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.displayMedium!),
      displaySmall: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.displaySmall!),
      headlineLarge: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.headlineLarge!),
      headlineMedium: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.headlineMedium!),
      headlineSmall: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.headlineSmall!),
      titleLarge: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.titleLarge!),
      titleMedium: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.titleMedium!),
      titleSmall: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.titleSmall!),
      labelLarge: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.labelLarge!),
      labelMedium: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.labelMedium!),
      labelSmall: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.labelSmall!),
      bodyLarge: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.bodyLarge!),
      bodyMedium: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.bodyMedium!),
      bodySmall: ResponsiveText.getResponsiveTextStyle(context, appTextTheme.bodySmall!),
    );
  }
}
