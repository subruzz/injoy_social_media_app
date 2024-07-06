import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';

class SeparatingDivider extends StatelessWidget {
  const SeparatingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          const Expanded(child: CustomDivider()),
          AppSizedBox.sizedBox10W,
          const CustomText('or'),
          AppSizedBox.sizedBox10W,
          const Expanded(child: CustomDivider()),
        ],
      ),
    );
  }
}
