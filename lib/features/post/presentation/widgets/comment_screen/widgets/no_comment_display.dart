import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';

class NoCommentDisplay extends StatelessWidget {
  const NoCommentDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      padding: AppPadding.large,
      child: Center(
        child: Text(
          'No comments yet.\nBe the first to comment!',
          style: AppTextTheme.bodyMeidumLightGreyVariant.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
