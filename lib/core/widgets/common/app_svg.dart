import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';

class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final Color? color;
  final BlendMode blendMode;
  final VoidCallback? onTap;
  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    this.width = 24.0,
    this.height = 24.0,
    this.color,
    this.onTap,
    this.blendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetPath,
          width: !isThatMobile ? width : width.h,
          height: !isThatMobile ? height : height.h,
          colorFilter: ColorFilter.mode(
              color != null ? color! : AppDarkColor().iconSecondarycolor,
              blendMode)),
    );
  }
}
