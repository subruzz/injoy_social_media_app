import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_button_with_icon.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';

import '../../../../../../core/const/app_config/app_border_radius.dart';
import '../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../core/theme/color/app_colors.dart';

class OtherUserFollowMessageSection extends StatelessWidget {
  const OtherUserFollowMessageSection(
      {super.key, required this.currentVisitedUser});
  final AppUser currentVisitedUser;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    final following = context.read<FollowingCubit>().followingList;

    return CustomAppPadding(
      padding: AppPadding.horizontalSmall,
      child: Row(
        children: [
          BlocConsumer<FollowunfollowCubit, FollowunfollowState>(
            builder: (context, state) {
              return Expanded(
                child: CustomButtonWithIcon(
                    iconSize: 20.w,
                    iconData: Icons.person_add_alt,
                    radius: AppBorderRadius.horizontalExtraLarge,
                    title: following.contains(currentVisitedUser.id)
                        ? 'Following'
                        : 'Follow',
                    onClick: () {
                      final amIFollowing =
                          following.contains(currentVisitedUser.id);
                      if (amIFollowing) {
                        --currentVisitedUser.followersCount;
                        context.read<FollowunfollowCubit>().unfollowUser(
                            user.id, currentVisitedUser.id, following);
                      } else {
                        ++currentVisitedUser.followersCount;

                        context.read<FollowunfollowCubit>().followUser(
                            user.id, currentVisitedUser.id, following);
                      }
                    }),
              );
            },
            listener: (context, state) {
              if (state is FollowFailure) {
                Messenger.showSnackBar(
                    message:
                        'An error occured while following this user,Please try again!');

              }
              if (state is UnfollowFailure) {
                Messenger.showSnackBar(
                    message:
                        'An error occured while Unfollowing this user,Please try again!');

                // following.add(currentUser.id);
              }
            },
          ),
          AppSizedBox.sizedBox10W,
          Expanded(
            child: CustomButtonWithIcon(
                iconColor: AppDarkColor().buttonBackground,
                iconSize: 20.w,
                iconData: CupertinoIcons.chat_bubble_text,
                borderColor: AppDarkColor().buttonBackground,
                color: AppDarkColor().background,
                radius: AppBorderRadius.extraLarge,
                title: 'Message',
                textColor: AppDarkColor().secondaryPrimaryText,
                onClick: () {}),
          )
        ],
      ),
    );
  }
}