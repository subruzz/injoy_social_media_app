import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/widgets/post_option_button.dart';

import '../../../common/models/partial_user_model.dart';

class PostTopDetails extends StatelessWidget {
  const PostTopDetails({
    super.key,
    required this.post,
    required this.pagecontroller,
    required this.currentPostIndex,
  });
  final PostEntity post;
  final PageController pagecontroller;
  final int currentPostIndex;
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
                      'user': PartialUser(
                          id: post.creatorUid,
                          userName: post.userFullName,
                          fullName: post.userFullName,
                          profilePic: post.userProfileUrl)
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
            PostOptionButton(
              currentPostIndex: currentPostIndex,
              isMyPost:
                  context.read<AppUserBloc>().appUser.id == post.creatorUid,
              pagecontroller: pagecontroller,
              post: post,
            ),
          ],
        ),
      ],
    );
  }
}
