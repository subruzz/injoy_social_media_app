import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/common/custom_divider.dart';

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
          const CustomText(   text: 'or'),
          AppSizedBox.sizedBox10W,
          const Expanded(child: CustomDivider()),
        ],
      ),
    );
  }
}
