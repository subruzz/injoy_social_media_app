import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ResponsiveText {
  ResponsiveText._();

  static TextStyle getResponsiveTextStyle(BuildContext context, TextStyle baseStyle) {
    TargetPlatform platform = Theme.of(context).platform;
    bool isMobile = platform == TargetPlatform.iOS || platform == TargetPlatform.android;
    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    bool isDesktop = MediaQuery.of(context).size.shortestSide >= 900;

    double fontSize = baseStyle.fontSize ?? 14.sp;

    if (isDesktop) {
      fontSize = fontSize * 1.2;
    } else if (isTablet) {
      fontSize = fontSize * 1.1;
    } else if (isMobile) {
      fontSize = fontSize;
    }

    return baseStyle.copyWith(fontSize: fontSize.sp);
  }
}
