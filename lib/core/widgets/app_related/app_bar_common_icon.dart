import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class AppBarCommonIcon extends StatelessWidget {
  const AppBarCommonIcon({super.key,  this.icon});
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        icon ?? Icons.close,
        size:isThatBtwMobAndTab?30: isThatTabOrDeskTop ? 30 : 30.w,
        color: AppDarkColor().iconPrimaryColor,
      ),
    );
  }
}
