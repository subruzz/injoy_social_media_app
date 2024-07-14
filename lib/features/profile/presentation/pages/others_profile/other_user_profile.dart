import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_follow_section/other_user_follow_message_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_posts.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/top_bar_section/top_bar_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';
import 'package:social_media_app/init_dependecies.dart';

class OtherUserProfilePage extends StatelessWidget {
  const OtherUserProfilePage(
      {super.key, required this.userName, required this.otherUserId});
  final String userName;
  final String otherUserId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              serviceLocator<OtherProfileCubit>()..getOtherProfile(otherUserId),
        ),
        BlocProvider(
          create: (context) => serviceLocator<GetOtherUserPostsCubit>()
            ..getOtherUserPosts(otherUserId),
        ),
      ],
      child: Scaffold(
        appBar: ProfilePageTopBarSection(
          userName: userName,
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
                        UserSocialActionDetailsSection(
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
                  const OtherUserPosts()
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
