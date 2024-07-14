import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class TagLocationSymbol extends StatelessWidget {
  const TagLocationSymbol({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppDarkColor().buttonBackground,
        radius: 30.w,
        child: child);
  }
}
