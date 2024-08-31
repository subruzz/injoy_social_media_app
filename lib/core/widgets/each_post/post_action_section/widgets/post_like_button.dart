import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../const/app_config/app_sizedbox.dart';

class PostLikeButton extends StatefulWidget {
  const PostLikeButton(
      {super.key, this.isReel = false, required this.me, required this.post});
  final AppUser me;
  final PostEntity post;
  final bool isReel;
  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isReel
        ? Column(
            children: [
              PostLike(
                  post: widget.post,
                  me: widget.me,
                  isReel: widget.isReel,
                  onUpdate: () {
                    setState(() {});
                  }),
              AppSizedBox.sizedBox5W,
              SocialActionText(text: widget.post.likes.length.toString())
            ],
          )
        : Row(
            children: [
              PostLike(
                  post: widget.post,
                  me: widget.me,
                  isReel: widget.isReel,
                  onUpdate: () {
                    setState(() {});
                  }),
              AppSizedBox.sizedBox5W,
              SocialActionText(text: widget.post.likes.length.toString())
            ],
          );
  }
}

class PostLike extends StatelessWidget {
  const PostLike(
      {super.key,
      required this.post,
      required this.me,
      required this.isReel,
      required this.onUpdate});
  final PostEntity post;
  final AppUser me;
  final bool isReel;
  final VoidCallback onUpdate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (post.likes.contains(me.id)) {
            post.likes.remove(me.id);

            context.read<LikePostBloc>().add(UnlikePostClickEvent(
                isReel: isReel,
                postId: post.postId,
                myId: me.id,
                ohterUseId: post.creatorUid));
          } else {
            // likeAnim();
            post.likes.add(me.id);
            context.read<LikePostBloc>().add(LikePostClickEvent(
                post: post,
                isReel: isReel,
                user: me,
                postId: post.postId,
                otherUserId: post.creatorUid));
          }

          /// it is better to user setstate here rather than bloc builder
          /// since we are using single instance of the bloc
          /// it will call the build of other like button as well
          /// here setstate only build the like button of the post that liked
          onUpdate();
        },
        child: Icon(
            size: isReel ? 30 : 25,
            post.likes.contains(me.id) ? Icons.favorite : Icons.favorite_border,
            color: post.likes.contains(me.id)
                ? AppDarkColor().iconSoftColor
                : isReel
                    ? Colors.white
                    : AppDarkColor().iconSecondarycolor));
  }
}
