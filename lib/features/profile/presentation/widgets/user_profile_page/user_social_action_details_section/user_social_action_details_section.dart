import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/dialog/general_dialog_for_web.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/pages/see_followers_following_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_social_action_details_section/widgets/user_social_attribute.dart';
import 'package:social_media_app/core/widgets/common/vertical_divider.dart';

class UserSocialActionDetailsSection extends StatelessWidget {
  const UserSocialActionDetailsSection(
      {super.key,
      required this.user,
      this.isMe = true,
      required this.localizations});
  final AppUser user;
  final bool isMe;
  final AppLocalizations localizations;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: UserSocialAttribute(
                name: localizations.posts,
                attribute: isMe
                    ? BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
                        buildWhen: (previous, current) =>
                            current is GetUserPostsSuccess ||
                            current is GetUserPostsError ||
                            (current is GetUserPostsSuccess &&
                                previous is GetUserPostsSuccess &&
                                current.userPosts.length !=
                                    previous.userPosts.length),
                        builder: (context, state) {
                          return CustomText(
                              text: state is GetUserPostsSuccess
                                  ? state.userPosts.length.toString()
                                  : '0');
                        },
                      )
                    : BlocBuilder<GetOtherUserPostsCubit,
                        GetOtherUserPostsState>(
                        builder: (context, state) {
                          return CustomText(
                              text: state is GetOtherUserPostsSuccess
                                  ? state.userPosts.length.toString()
                                  : '0');
                        },
                      )),
          ),
          const CustomVerticalDivider(),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isThatTabOrDeskTop) {
                  GeneralDialogForWeb.showSideDialog(
                    context: context,
                    child: const SeeFollowersFollowingPage(
                      initialIndex: 0,
                    ),
                  );
                  return;
                }
                isMe
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeeFollowersFollowingPage(
                          initialIndex: 0,
                        ),
                      ))
                    : null;
              },
              child: UserSocialAttribute(
                name: localizations.following,
                attribute:
                    BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
                  builder: (context, state) {
                    return isMe
                        ? CustomText(
                            text: context
                                .read<AppUserBloc>()
                                .appUser
                                .following
                                .length
                                .toString())
                        : CustomText(text: user.following.length.toString());
                  },
                ),
              ),
            ),
          ),
          const CustomVerticalDivider(),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isThatTabOrDeskTop) {
                  GeneralDialogForWeb.showSideDialog(
                    context: context,
                    child: const SeeFollowersFollowingPage(
                      initialIndex: 1,
                    ),
                  );
                  return;
                }
                isMe
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SeeFollowersFollowingPage(
                          initialIndex: 1,
                        ),
                      ))
                    : null;
              },
              child: UserSocialAttribute(
                  name: localizations.followers,
                  attribute: isMe
                      ? CustomText(text: user.followersCount.toString())
                      : BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
                          builder: (context, state) {
                            return CustomText(
                                text: user.followersCount.toString());
                          },
                        )),
            ),
          ),
        ],
      ),
    );
  }
}
