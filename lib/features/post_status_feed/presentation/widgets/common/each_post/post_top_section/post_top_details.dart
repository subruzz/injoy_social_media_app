import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
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
                size: 22,
              ),
            ),
            AppSizedBox.sizedBox10W,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('@${post.username}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall),
                    AppSizedBox.sizedBox15W,
                    // Text(
                    //   post.createAt.toDate().timeAgo(),
                    //   style: Theme.of(context).textTheme.bodySmall,
                    //   overflow:
                    //       TextOverflow.ellipsis, // Handle overflow by ellipsis
                    // ),
                  ],
                ),
                Text(post.userFullName,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizedBox.sizedBox10W,
            // const PostOptionButton(),
          ],
        ),
      ],
    );
  }
}
