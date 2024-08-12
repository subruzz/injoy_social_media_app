import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_follow_section/other_user_follow_message_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_posts.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/top_bar_section/top_bar_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/bloc/who_visited/who_visited_bloc.dart';
import 'package:social_media_app/init_dependecies.dart';

class OtherUserProfilePage extends StatefulWidget {
  const OtherUserProfilePage({
    super.key,
    required this.user,
  });
  final PartialUser user;

  @override
  State<OtherUserProfilePage> createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<WhoVisitedBloc>().add(AddUserToVisited(
        myId: context.read<AppUserBloc>().appUser.id,
        visitedUserId: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<OtherProfileCubit>()
            ..getOtherProfile(widget.user.id),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetOtherUserPostsCubit>()
            ..getOtherUserPosts(widget.user),
        ),
      ],
      child: Scaffold(
        appBar: ProfilePageTopBarSection(
          userName: widget.user.userName,
          isMe: false,
        ),
        body: BlocConsumer<OtherProfileCubit, OtherProfileState>(
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
                          localizations: l10n!,
                          user: currentUser,
                          isMe: false,
                        ),
                        AppSizedBox.sizedBox15H,
                        OtherUserFollowMessageSection(
                            currentVisitedUser: currentUser),
                        AppSizedBox.sizedBox10H,
                        const CustomDivider(),
                      ],
                    ),
                  ),
                  // TabBarView for displaying content of each tab
                  OtherUserPosts(
                    userName: widget.user.userName ?? '',
                  )
                ],
              );
            }
            return const Center(child: AppErrorGif());
          },
        ),
      ),
    );
  }
}
