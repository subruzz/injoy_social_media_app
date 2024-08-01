import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../../../../../core/const/app_config/app_sizedbox.dart';

class PostLikeButton extends StatefulWidget {
  const PostLikeButton({super.key, required this.me, required this.post});
  final AppUser me;
  final PostEntity post;

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () {
              if (widget.post.likes.contains(widget.me.id)) {
                widget.post.likes.remove(widget.me.id);

                context.read<LikePostBloc>().add(UnlikePostClickEvent(
                    postId: widget.post.postId,
                    myId: widget.me.id,
                    ohterUseId: widget.post.creatorUid));
              } else {
                // likeAnim();
                widget.post.likes.add(widget.me.id);
                context.read<LikePostBloc>().add(LikePostClickEvent(
                    user: widget.me,
                    postId: widget.post.postId,
                    otherUserId: widget.post.creatorUid));
              }

              /// it is better to user setstate here rather than bloc builder
              /// since we are using single instance of the bloc
              /// it will call the build of other like button as well
              /// here setstate only build the like button of the post that liked
              setState(() {});
            },
            child: Icon(
                size: 25,
                widget.post.likes.contains(widget.me.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.post.likes.contains(widget.me.id)
                    ? AppDarkColor().iconSoftColor
                    : AppDarkColor().iconSecondarycolor)),
        AppSizedBox.sizedBox5W,
        SocialActionText(text: widget.post.likes.length.toString())
      ],
    );
  }
}
