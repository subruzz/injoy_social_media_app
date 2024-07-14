import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_profile_tab_section/widgets/user_posts_tab.dart';
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
        TabBar(
          labelColor: AppDarkColor().secondaryPrimaryText,
          dividerColor: AppDarkColor().secondaryBackground,
          indicatorColor: AppDarkColor().iconSecondarycolor,
          tabs: const [
            UserTab(icon: '', tabTitle: 'Posts'),
            UserTab(icon: 'Icons.add_to_photos_sharp,', tabTitle: 'Posts')
          ],
        ),
        const Expanded(
          child: TabBarView(
            children: [
              UsersPostsTab(),
              PostsTab(),
            ],
          ),
        )
      ],
    );
  }
}
