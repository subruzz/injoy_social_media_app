import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/others_profile/other_user_follow_message_section.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';

import '../../../../../core/widgets/common/app_error_gif.dart';
import '../../../../../core/const/app_config/app_sizedbox.dart';
import '../user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';

class OtherUserDetails extends StatelessWidget {
  const OtherUserDetails({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtherProfileCubit, OtherProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OtherProfileLoading) {
          return const Center(child: CircularLoadingGrey());
        }
        if (state is OtherProfileSuccess) {
          final currentUser = state.userProfile;
          return Column(
            children: [
              // Profile info
              Padding(
                padding: AppPadding.medium,
                child: Column(
                  children: [
                    UserBasicDetailSection(user: currentUser),
                    AppSizedBox.sizedBox10H,
                    UserSocialActionDetailsSection(
                      localizations: l10n,
                      user: currentUser,
                      isMe: false,
                    ),
                    AppSizedBox.sizedBox15H,
                    OtherUserFollowMessageSection(
                        currentVisitedUser: currentUser),
                  ],
                ),
              ),
              // TabBarView for displaying content of each tab
              // OtherUserPosts(
              //   userName: widget.user.userName ?? '',
              // )
            ],
          );
        }
        return const Center(child: AppErrorGif());
      },
    );
  }
}
