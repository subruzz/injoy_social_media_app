import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class SeparatingDivider extends StatelessWidget {
  const SeparatingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Divider(color: AppDarkColor().secondaryBackground),
          ),
          AppSizedBox.sizedBox10W,
          const Text(
            'or',
            style: TextStyle(),
          ),
          AppSizedBox.sizedBox10W,
          Expanded(
            child: Divider(color: AppDarkColor().secondaryBackground),
          ),
        ],
      ),
    );
  }
}
