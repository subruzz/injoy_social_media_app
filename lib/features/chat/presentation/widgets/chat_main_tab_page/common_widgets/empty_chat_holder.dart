import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';

class EmptyChatHolder extends StatelessWidget {
  const EmptyChatHolder({super.key, this.message = 'No chats found'});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppAssetsConst.nochatHolder, width: 120.w),
        AppSizedBox.sizedBox10H,
        Text(
          message,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
