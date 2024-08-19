import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_button_with_icon.dart';

import 'package:social_media_app/features/profile/presentation/bloc/other_user/follow_unfollow/followunfollow_cubit.dart';

import '../../../../../core/const/app_config/app_border_radius.dart';
import '../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../core/theme/color/app_colors.dart';
import '../../../../chat/presentation/pages/personal_chat_builder.dart';

class OtherUserFollowMessageSection extends StatelessWidget {
  const OtherUserFollowMessageSection(
      {super.key, required this.currentVisitedUser});
  final AppUser currentVisitedUser;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = context.read<AppUserBloc>().appUser;
    return CustomAppPadding(
      padding: AppPadding.horizontalSmall,
      child: Row(
        children: [
          BlocConsumer<FollowunfollowCubit, FollowunfollowState>(
            buildWhen: (previous, current) =>
                current is FollowLoading ||
                (previous is FollowLoading && current is FollowLoading),
            builder: (context, state) {
              return Expanded(
                child: CustomButtonWithIcon(
                    fontSize: context.read<AppLanguageCubit>().state.locale ==
                            const Locale('ml')
                        ? 13
                        : null,
                    iconSize: isThatTabOrDeskTop ? 20 : 20.w,
                    iconData: Icons.person_add_alt,
                    radius: AppBorderRadius.horizontalExtraLarge,
                    title: me.following.contains(currentVisitedUser.id)
                        ? l10n!.following
                        : l10n!.follow,
                    onClick: () {
                      final amIFollowing =
                          me.following.contains(currentVisitedUser.id);
                      log('in the follow butto $amIFollowing');
                      if (amIFollowing) {
                        me.following.remove(currentVisitedUser.id);
                        --currentVisitedUser.followersCount;
                        // context.read<NotificationCubit>().deleteNotification(
                        //     notificationCheck: NotificationCheck(
                        //         receiverId: currentVisitedUser.id,
                        //         senderId: me.id,
                        //         uniqueId: currentVisitedUser.id,
                        //         notificationType: NotificationType.profile,
                        //         isThatLike: false,
                        //         isThatPost: false));
                        // context.read<FollowunfollowCubit>().unfollowUser(
                        //       myId: me.id,
                        //       otherId: currentVisitedUser.id,
                        //     );
                      } else {
                        ++currentVisitedUser.followersCount;
                        me.following.add(currentVisitedUser.id);

                        // context.read<NotificationCubit>().createNotification(
                        //         notification: CustomNotification(
                        //       text: "started following you.",
                        //       time: Timestamp.now(),
                        //       senderId: me.id,
                        //       uniqueId: currentVisitedUser.id,
                        //       receiverId: currentVisitedUser.id,
                        //       personalUserName: me.userName ?? '',
                        //       personalProfileImageUrl: me.profilePic,
                        //       notificationType: NotificationType.profile,
                        //       senderName: me.userName ?? '',
                        //     ));
                        // context.read<FollowunfollowCubit>().followUser(
                        //       me.id,
                        //       currentVisitedUser.id,
                        //     );
                      }
                      log('state is ${context.read<FollowunfollowCubit>().state}');
                      context.read<FollowunfollowCubit>().followUnfollowAction(
                          user: me,
                          myid: me.id,
                          otherId: currentVisitedUser.id,
                          isFollowing: amIFollowing);
                    }),
              );
            },
            listener: (context, state) {
              if (state is FollowFailure) {
                Messenger.showSnackBar(message: l10n!.errorFollow);
              }
              if (state is UnfollowFailure) {
                Messenger.showSnackBar(message: l10n!.errorUnfollow);

                // following.add(currentUser.id);
              }
            },
          ),
          AppSizedBox.sizedBox10W,
          Expanded(
              child: CustomButtonWithIcon(
                  iconColor: AppDarkColor().buttonBackground,
                  iconSize: isThatTabOrDeskTop ? 20 :20.w,
                  iconData: CupertinoIcons.chat_bubble_text,
                  borderColor: AppDarkColor().buttonBackground,
                  color: AppDarkColor().background,
                  radius: AppBorderRadius.extraLarge,
                  title: l10n!.message,
                  textColor: AppDarkColor().secondaryPrimaryText,
                  onClick: () {
                    // context.read<MessageInfoStoreCubit>().setDataForChat(
                    //     myName: me.userName ?? '',
                    //     myProfil: me.profilePic,
                    //     receiverProfile: currentVisitedUser.profilePic,
                    //     receiverName: currentVisitedUser.userName ?? '',
                    //     recipientId: currentVisitedUser.id);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonalChatBuilder(
                          otherUserId: currentVisitedUser.id),
                    ));
                  })),
        ],
      ),
    );
  }
}
