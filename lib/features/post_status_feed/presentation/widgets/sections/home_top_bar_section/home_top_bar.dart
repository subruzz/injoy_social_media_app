import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/widgets/common/app_top_bar_text_with_premium.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_top_bar_section/widget/home_top_notification.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      expandedHeight: kToolbarHeight,
      title: Padding(
        padding: AppPadding.horizontalSmall,
        child: const AppTopBarTextWithPremium(),
      ),
      actions: const [HomeTopNotification()],
    );
  }
}
