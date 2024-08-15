import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';

class SocialActionText extends StatelessWidget {
  const SocialActionText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppTextTheme.labelMediumPureWhiteVariations.labelMedium
            ?.copyWith(fontSize: 13.sp));
  }
}
