import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/premium_badge.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, this.profile, this.isPremium = true});

  final String? profile;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      expandedHeight: kToolbarHeight,
      flexibleSpace: FlexibleSpaceBar(
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
        // This space is for custom widgets
        background: Container(
          padding: AppPadding.only(left: 16, right: 16, bottom: 8),
          child: Align(
              alignment: Alignment.bottomRight,
              child: BlocBuilder<AppUserBloc, AppUserState>(
                buildWhen: (previous, current) {
                  if (previous is AppUserLoggedIn &&
                      current is AppUserLoggedIn) {
                    return (previous.user.profilePic !=
                        current.user.profilePic);
                  }
                  return false;
                },
                builder: (context, state) {
                  return state is AppUserLoggedIn &&
                          state.user.profilePic != null
                      ? CircularUserProfile(
                          size: 21, profile: state.user.profilePic)
                      : const EmptyDisplay();
                },
              )

              // profile != null
              //     ? CircularUserProfile(size: 21, profile: profile)
              //     : const SizedBox.shrink(),
              ),
        ),
      ),
      // Keep the actions fixed to the right side of the app bar
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
}
