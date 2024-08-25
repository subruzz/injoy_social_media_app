import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class CommonEmptyHolder extends StatelessWidget {
  const CommonEmptyHolder(
      {super.key,
      this.size = 120,
      required this.message,
      required this.asset,
      this.isGif = false,
      this.color});
  final String message;
  final bool isGif;
  final double size;
  final String asset;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isGif
            ? Image.asset(asset,
                width: isThatTabOrDeskTop ? size : size.w, color: color)
            : Lottie.asset(asset, width: isThatTabOrDeskTop ? size : size.w),
        AppSizedBox.sizedBox10H,
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: isThatTabOrDeskTop ? 15 : null),
        ),
      ],
    );
  }
}
