import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';

class AppErrorGif extends StatelessWidget {
  const AppErrorGif({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssetsConst.errorGif,
          height: 125,
          width: 125,
        ),
        Text(
          l10n!.somethingWentWrong,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
