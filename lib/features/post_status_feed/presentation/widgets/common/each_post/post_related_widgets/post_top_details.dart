import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_top_section/widgets/post_option_button.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

class PostTopDetails extends StatelessWidget {
  const PostTopDetails({
    super.key,
    required this.post,
  });
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyAppRouteConst.otherUserProfile,
                    arguments: {
                      'userName': post.username,
                      'otherUserId': post.creatorUid,
                    });
              },
              child: CircularUserProfile(
                profile: post.userProfileUrl,
                size: 23,
              ),
            ),
            AppSizedBox.sizedBox10W,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('@${post.username}',
                    style: Theme.of(context).textTheme.labelSmall),
                Text(post.userFullName,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.createAt.toDate().timeAgo(),
              style: Theme.of(context).textTheme.bodySmall,
              overflow:
                  TextOverflow.ellipsis, // Handle overflow by ellipsis
            ),
            AppSizedBox.sizedBox10W,
            const PostOptionButton(),
          ],
        ),
      ],
    );
  }
}
