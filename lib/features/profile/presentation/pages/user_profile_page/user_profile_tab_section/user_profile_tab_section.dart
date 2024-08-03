import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_profile_tab_section/widgets/user_liked_posts.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_tab.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_profile_tab_section/widgets/user_tab.dart';

class UserProfileTabSection extends StatelessWidget {
  const UserProfileTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizedBox.sizedBox5H,
        const TabBar(
          tabs: [
            UserTab(icon: '', tabTitle: 'Posts'),
            UserTab(icon: '', tabTitle: 'Liked')
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: [
              UsersPostsTab(),
              UserLikedPostsTab(),
            ],
          ),
        )
      ],
    );
  }
}
