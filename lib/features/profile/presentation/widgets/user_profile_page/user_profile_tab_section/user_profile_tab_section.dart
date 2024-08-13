import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/user_shorts.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/media_tab.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/user_tab.dart';

import '../../../../../../core/const/extensions/localization.dart';

class UserProfileTabSection extends StatelessWidget {
  const UserProfileTabSection(
      {super.key,
      required this.localizations,
      required this.isMe,
      this.userName});
  final AppLocalizations localizations;
  final bool isMe;
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizedBox.sizedBox5H,
        TabBar(
          tabs: [
            UserTab(icon: '', tabTitle: localizations.posts),
            UserTab(icon: '', index: 1, tabTitle: localizations.shorts)
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              isMe
                  ? const MypostsTab()
                  : OtherUserPosts(
                      userName: userName,
                    ),
              isMe ? const MyShortsTab() : const OtherUserShortsTab()
            ],
          ),
        )
      ],
    );
  }
}
