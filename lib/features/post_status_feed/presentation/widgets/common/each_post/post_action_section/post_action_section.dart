import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_comment_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_send_button.dart';

class SocialActions extends StatelessWidget {
  const SocialActions(
      {super.key,
      this.isCommentNeeded = true,
      required this.post,
      required this.likeAnim});
  final PostEntity post;
  final VoidCallback likeAnim;
  final bool isCommentNeeded;
  @override
  Widget build(BuildContext context) {
    final appUser = context.read<AppUserBloc>().appUser;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Likes
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PostLikeButton(me: appUser, post: post),
                  AppSizedBox.sizedBox20W,
                  // Comments
                  if (isCommentNeeded) PostCommentButton(post: post)
                ],
              ),
             const PostSendButton()
            ],
          ),
        ),
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.bookmark_add_outlined,
        //       size: 25,
        //       color: AppDarkColor().iconSoftColor,
        //     ))
        // Save
      ],
    );
  }
}
