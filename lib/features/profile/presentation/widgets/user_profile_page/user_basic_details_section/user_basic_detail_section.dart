import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';

import '../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../../../core/utils/responsive/constants.dart';
import '../../../../../../core/widgets/common/empty_display.dart';

class UserBasicDetailSection extends StatelessWidget {
  const UserBasicDetailSection({super.key, required this.user});
  final AppUser user;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Column(
        children: [
          Hero(
            tag: user.id,
            child: CircularUserProfile(
              wantSecProfile: true,
              size: 55,
              profile: user.profilePic,
            ),
          ),
          AppSizedBox.sizedBox3H,
          Text(
            user.fullName ?? '',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          AppSizedBox.sizedBox3H,
          if (user.occupation != null)
            Text(user.occupation ?? '',
                style: AppTextTheme.getResponsiveTextTheme(context).bodyMedium),
          AppSizedBox.sizedBox3H,
          if (user.about != null)
            Text(user.about ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class MyProfileBasicDetails extends StatelessWidget {
  const MyProfileBasicDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Column(
        children: [
          BlocBuilder<AppUserBloc, AppUserState>(
            buildWhen: (previous, current) {
              if (previous is AppUserLoggedIn && current is AppUserLoggedIn) {
                return (previous.user.profilePic != current.user.profilePic);
              }
              return false;
            },
            builder: (context, state) {
              return state is AppUserLoggedIn
                  ? CircularUserProfile(
                      wantSecProfile: true,
                      size: 55,
                      profile: state.user.profilePic)
                  : const EmptyDisplay();
            },
          ),
          BlocBuilder<AppUserBloc, AppUserState>(
            buildWhen: (previous, current) {
              if (previous is AppUserLoggedIn && current is AppUserLoggedIn) {
                return (previous.user.fullName != current.user.fullName);
              }
              return false;
            },
            builder: (context, state) {
              return state is AppUserLoggedIn
                  ? MyprofileContentHelper(
                      child: Text(state.user.fullName ?? '',
                          style: AppTextTheme.getResponsiveTextTheme(context)
                              .headlineLarge),
                    )
                  : const EmptyDisplay();
            },
          ),
          BlocBuilder<AppUserBloc, AppUserState>(
            buildWhen: (previous, current) {
              if (previous is AppUserLoggedIn && current is AppUserLoggedIn) {
                return (previous.user.occupation != current.user.occupation);
              }
              return false;
            },
            builder: (context, state) {
              return state is AppUserLoggedIn && state.user.occupation != null
                  ? MyprofileContentHelper(
                      child: Text(state.user.occupation ?? '',
                          textAlign: TextAlign.center,
                          style: AppTextTheme.getResponsiveTextTheme(context)
                              .bodyMedium),
                    )
                  : const EmptyDisplay();
            },
          ),
          BlocBuilder<AppUserBloc, AppUserState>(
            buildWhen: (previous, current) {
              if (previous is AppUserLoggedIn && current is AppUserLoggedIn) {
                return (previous.user.about != current.user.about);
              }
              return false;
            },
            builder: (context, state) {
              return state is AppUserLoggedIn && state.user.about != null
                  ? MyprofileContentHelper(
                      child: Text(state.user.about ?? '',
                          textAlign: TextAlign.center,
                          style: AppTextTheme.getResponsiveTextTheme(context)
                              .bodySmall),
                    )
                  : const EmptyDisplay();
            },
          ),
        ],
      ),
    );
  }
}

class MyprofileContentHelper extends StatelessWidget {
  const MyprofileContentHelper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [AppSizedBox.sizedBox3H, child],
    );
  }
}
