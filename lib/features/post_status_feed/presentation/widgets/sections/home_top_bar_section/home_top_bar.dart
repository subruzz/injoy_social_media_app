import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/premium_badge.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/widget/home_top_notification.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.isPremium = true});

  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      expandedHeight: kToolbarHeight,
      title: Padding(
        padding: AppPadding.horizontalSmall,
        child: Row(
          children: [
            Text(
              'INJOY',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(letterSpacing: 5),
            ),
            AppSizedBox.sizedBox5W,
            if (isPremium) const PremiumBadge()
          ],
        ),
      ),
      actions: const [HomeTopNotification()],
    );
  }
}
