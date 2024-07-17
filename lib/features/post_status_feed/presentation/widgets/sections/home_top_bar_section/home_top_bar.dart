import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key, this.profile});
  final String? profile;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'INJOY',
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(letterSpacing: 5),
      ),
      actions: [
        if (profile != null)
          Padding(
            padding: AppPadding.onlyRightMedium,
            child: CircularUserProfile(size: 21, profile: profile),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
