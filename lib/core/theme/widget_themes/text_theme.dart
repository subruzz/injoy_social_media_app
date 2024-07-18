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
      height: 1.5,
    ),
    displaySmall: TextStyle(
      color: _color.primaryText,
      fontWeight: FontWeight.w600,
      fontSize: 23.sp,
    ),
    headlineLarge: TextStyle(
      letterSpacing: 1.2,
      color: _color.primaryText,
      fontWeight: FontWeight.w500,
      fontSize: 21.sp,
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
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: _color.primaryText,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: _color.primaryText,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: _color.primaryText,
      fontSize: 14.sp,
    ),
    bodyMedium: TextStyle(
        color: _color.secondaryText,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
      color: _color.secondaryText,
      fontSize: 12.sp,
    ),
  );

  // Variations for different styles
  static TextTheme titleLargeVariations = TextTheme(
    titleLarge: TextStyle(
      color: Colors.red, // Example: Red color
      fontSize: 18.sp,
    ),
  );

  static TextTheme titleMediumBlackVariation = TextTheme(
    titleMedium: TextStyle(
      color: AppDarkColor().background,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme titleSmallVariations = TextTheme(
    titleSmall: TextStyle(
      color: Colors.grey, // Example: Grey color
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    ),
  );

  static TextTheme labelLargeVariations = TextTheme(
    labelLarge: TextStyle(
      color: Colors.blue, // Example: Blue color
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    ),
  );

  static TextTheme labelMediumPureWhiteVariations = TextTheme(
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 15.sp,
    ),
  );
  static TextTheme bodysmallPureWhiteVariations = TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 11.sp,
    ),
  );

  static TextTheme labelSmallVariations = TextTheme(
    labelSmall: TextStyle(
      color: Colors.green, // Example: Green color
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
    ),
  );
  static TextTheme bodyMeidumLightGreyVariant = TextTheme(
    bodyMedium: TextStyle(
      color: const Color.fromARGB(255, 209, 208, 208),
      fontSize: 14.sp,
    ),
  );
  static TextTheme bodyMeidumwhiteVariant = TextTheme(
    bodyMedium: TextStyle(
        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
  );
  static TextTheme labelMediumRedVariant = TextTheme(
    labelMedium: TextStyle(
      color: _color.secondaryPrimaryText,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    ),
  );
}
