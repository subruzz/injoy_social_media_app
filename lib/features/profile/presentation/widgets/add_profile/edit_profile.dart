import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class EditProfileIcon extends StatelessWidget {
  const EditProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isThatMobile ? 20.h : 20,
      width: isThatMobile ? 20.w : 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: AppDarkColor().buttonBackground,
      ),
      child: Icon(
        Icons.edit,
        color: AppDarkColor().background,
        size: isThatMobile ? 13.w : 13,
      ),
    );
  }
}
