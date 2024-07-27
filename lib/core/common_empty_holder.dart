import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';

class CommonEmptyHolder extends StatelessWidget {
  const CommonEmptyHolder(
      {super.key,
      this.size=120,
      required this.message,
      required this.asset,
      this.isGif = false});
  final String message;
  final bool isGif;
  final double size;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isGif
            ? Image.asset(asset, width: size. w)
            : Lottie.asset(asset, width: size .w),
        AppSizedBox.sizedBox10H,
        Text(
          message,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
