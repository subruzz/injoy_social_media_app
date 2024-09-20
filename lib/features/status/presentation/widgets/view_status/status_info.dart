import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';

class StatusInfo extends StatelessWidget {
  const StatusInfo(
      {super.key,
      required this.isMe,
      required this.user,
      required this.statusEntity,
      required this.created,
      required this.currentStoryIndex});
  final bool isMe;
  final AppUser? user;
  final StatusEntity? statusEntity;
  final ValueNotifier<int> currentStoryIndex;
  final DateTime created;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isMe
            ? Hero(
                tag: user!.id,
                child: CircularUserProfile(
                  profile: user!.profilePic,
                  size: 25,
                ),
              )
            : Hero(
                tag: statusEntity!.uId,
                child: CircularUserProfile(
                  profile: statusEntity!.profilePic,
                  size: 25,
                ),
              ),
        AppSizedBox.sizedBox5W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMe ? 'You' : statusEntity!.userName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            ValueListenableBuilder(
              valueListenable: currentStoryIndex,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Text(created.timeAgo(),
                    style: AppTextTheme.getResponsiveTextTheme(context).bodySmall);
              },
            ),
          ],
        ),
      ],
    );
  }
}
