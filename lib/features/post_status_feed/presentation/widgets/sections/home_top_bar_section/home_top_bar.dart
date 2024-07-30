import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/premium_badge.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key, this.profile, this.isPremium = true});

  final String? profile;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
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
      actions: [
        if (profile != null)
          Padding(
            padding: AppPadding.onlyRightMedium,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CircularUserProfile(size: 21, profile: profile),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


