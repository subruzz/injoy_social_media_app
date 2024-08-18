import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/common_empty_holder.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';

import '../../../../core/widgets/loading/circular_loading.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppCustomAppbar(
          title: "Notifications",
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationFailed) {
              return const Center(
                child: AppErrorGif(),
              );
            }
            if (state is NotificationLoading) {
              return const Center(
                child: CircularLoadingGrey(),
              );
            }
            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return const Center(
                  child: CommonEmptyHolder(
                      size: 170,
                      isGif: true,
                      message: 'No new notifications',
                      asset: AppAssetsConst.noNotification),
                );
              }
              log('notification is ${state.notifications}');
              return CustomAppPadding(
                child: ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return NotificationCard(
                      notification: notification,
                    );
                  },
                ),
              );
            }
            return const EmptyDisplay();
          },
        ));
  }
}

class NotificationCard extends StatelessWidget {
  final CustomNotification notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification.notificationId),
      background: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Padding around the background
        alignment: Alignment.centerRight,
        color: AppDarkColor().buttonBackground,
        child: const Row(
          mainAxisSize:
              MainAxisSize.min, // Make the row only as wide as necessary
          children: [
            SizedBox(width: 16.0), // Space between the item and the background
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 30, // Size of the delete icon
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<NotificationCubit>().deleteMynotification(
              myId: context.read<AppUserBloc>().appUser.id,
              notificationId: notification.notificationId,
            );
      },
      child: Padding(
        padding: AppPadding.onlyTopSmall,
        child: ClipRRect(
          borderRadius: isThatTabOrDeskTop
              ? BorderRadius.circular(10)
              : BorderRadius.circular(AppBorderRadius.getRadius(10)),
          child: InkWell(
            onTap: () {
              if (notification.notificationType == NotificationType.profile) {
                Navigator.pushNamed(
                  context,
                  MyAppRouteConst.otherUserProfile,
                  arguments: {
                    'userName': notification.senderName,
                    'otherUserId': notification.senderId
                  },
                );
              } else if (notification.notificationType ==
                  NotificationType.post) {}
            },
            child: Container(
              padding:
                  isThatTabOrDeskTop ? AppPadding.small : AppPadding.medium,
              decoration: BoxDecoration(
                borderRadius: isThatTabOrDeskTop
                    ? BorderRadius.circular(10)
                    : BorderRadius.circular(AppBorderRadius.getRadius(10)),
                border: Border.all(
                  color: AppDarkColor().secondaryBackground,
                  width: 2.0,
                ),
              ),
              child: Row(
                children: [
                  CircularUserProfile(
                    size: 25,
                    profile: notification.personalProfileImageUrl,
                  ),
                  AppSizedBox.sizedBox15W,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${notification.senderName} ${notification.text}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: isThatTabOrDeskTop ? 12 : null),
                        ),
                        AppSizedBox.sizedBox5H,
                        Text(notification.time.toDate().timeAgo(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: AppDarkColor().secondaryPrimaryText,
                                    fontSize: isThatTabOrDeskTop ? 10 : 10.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
