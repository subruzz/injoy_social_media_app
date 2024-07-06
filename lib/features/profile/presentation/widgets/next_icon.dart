import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class NextIcon extends StatelessWidget {
  const NextIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward,
      color: AppDarkColor().iconPrimaryColor,
      size: 40.w,
    );
  }
}
