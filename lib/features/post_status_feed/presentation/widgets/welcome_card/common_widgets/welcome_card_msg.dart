import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';

import '../../../../../../core/const/app_config/app_sizedbox.dart';

class WelcomeCardMessage extends StatelessWidget {
  const WelcomeCardMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n!.noPostsYet, style: Theme.of(context).textTheme.displaySmall),
        AppSizedBox.sizedBox5H,
        Text(
          l10n.followFriendsDiscoverStories,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
