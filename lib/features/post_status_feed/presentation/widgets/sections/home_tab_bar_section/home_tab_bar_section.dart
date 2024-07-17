import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_tab_bar_section/widgets/following_post_tab_view.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_tab_bar_section/widgets/for_you_posts_tab_view.dart.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_tab_bar_section/widgets/home_tab_bar.dart';

class HomeTabBarSection extends StatelessWidget {
  const HomeTabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizedBox.sizedBox5H,
        const HomeTabBar(),
        const Expanded(
          child: TabBarView(
            children: [
              FollowingPostTabView(),
              ForYouPostsTabView(),
            ],
          ),
        )
      ],
    );
  }
}
