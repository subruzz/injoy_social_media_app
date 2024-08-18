import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class TagLocationSymbol extends StatelessWidget {
  const TagLocationSymbol({super.key, required this.child, required this.size});
  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: AppDarkColor().buttonBackground,
        radius: isThatTabOrDeskTop ? size : size.w,
        child: child);
  }
}
