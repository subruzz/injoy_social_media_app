import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class ResponsiveText {
  ResponsiveText._();

  static TextStyle getResponsiveTextStyle(
      BuildContext context, TextStyle baseStyle) {
    double fontSize = isThatTabOrDeskTop
        ? baseStyle.fontSize ?? 14
        : baseStyle.fontSize ?? 14.sp;

    if (isThatTabOrDeskTop) {
      fontSize = fontSize * 1.2;
    } else if (isThatTab) {
      fontSize = fontSize * 1.1;
    } else {
      fontSize = fontSize;
    }

    return baseStyle.copyWith(
        fontSize:
            isThatTabOrDeskTop || isThatBtwMobAndTab ? fontSize : fontSize.sp);
  }
}
