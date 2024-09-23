import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class CommonEmptyHolder extends StatelessWidget {
  const CommonEmptyHolder({
    super.key,
    this.size = 120,
    required this.message,
    required this.asset,
    this.isGif = false,
    this.showLottie = false,
    this.color,
    this.showText = true,
  });
  final bool showText;

  /// The message to display when there's no content.
  final String message;

  /// Indicates if the asset is a GIF.
  final bool isGif;

  /// The size of the asset.
  final double size;

  /// The asset path for the image or Lottie animation.
  final String asset;

  /// Optional color for the asset (if applicable).
  final Color? color;

  /// Indicates whether to show a Lottie animation based on a condition.
  final bool showLottie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Show GIF if isGif is true; otherwise, show Lottie animation
        isGif
            ? Image.asset(
                asset,
                width: isThatTabOrDeskTop ? size : size.w,
                color: color,
              )
            : showLottie
                ? Lottie.asset(
                    asset,
                    width: isThatTabOrDeskTop ? size : size.w,
                  )
                : Container(), // Placeholder when not showing Lottie

        AppSizedBox.sizedBox10H,

        // Display the message text based on the condition
        if (showText)
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
