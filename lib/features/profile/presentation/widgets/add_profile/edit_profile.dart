import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class EditProfileIcon extends StatelessWidget {
  const EditProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 20.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: AppDarkColor().buttonBackground,
      ),
      child: Icon(
        Icons.edit,
        color: AppDarkColor().background,
        size: 13.w,
      ),
    );
  }
}
