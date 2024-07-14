import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/pages/see_followers_following_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/user_social_action_details_section/widgets/user_social_attribute.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/vertical_divider.dart';

class UserSocialActionDetailsSection extends StatelessWidget {
  const UserSocialActionDetailsSection(
      {super.key, required this.user, this.isMe = true});
  final AppUser user;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserSocialAttribute(
              name: 'Posts',
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
                        return CustomText(state is GetUserPostsSuccess
                            ? state.userPosts.length.toString()
                            : '0');
                      },
                    )
                  : BlocBuilder<GetOtherUserPostsCubit, GetOtherUserPostsState>(
                      builder: (context, state) {
                        return CustomText(state is GetOtherUserPostsSuccess
                            ? state.userPosts.length.toString()
                            : '0');
                      },
                    )),
          const CustomVerticalDivider(),
          GestureDetector(
            onTap: () {
              isMe
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SeeFollowersFollowingPage(
                        initialIndex: 0,
                      ),
                    ))
                  : null;
            },
            child: UserSocialAttribute(
              name: 'Following',
              attribute: CustomText(isMe
                  ? context
                      .read<FollowingCubit>()
                      .followingList
                      .length
                      .toString()
                  : user.followingCount.toString()),
            ),
          ),
          const CustomVerticalDivider(),
          GestureDetector(
            onTap: () {
              isMe
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SeeFollowersFollowingPage(
                        initialIndex: 1,
                      ),
                    ))
                  : null;
            },
            child: UserSocialAttribute(
                name: 'Followers',
                attribute: isMe
                    ? CustomText(user.followersCount.toString())
                    : BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
                        builder: (context, state) {
                          return CustomText(user.followersCount.toString());
                        },
                      )),
          ),
        ],
      ),
    );
  }
}