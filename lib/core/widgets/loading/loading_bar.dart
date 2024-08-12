import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.stretchedDots(
          color: AppDarkColor().loadingColor,
          size: 50,
        ),
        Text(l10n!.justASecond)
      ],
    ));
  }
}
