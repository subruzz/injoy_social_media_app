import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/save_post/save_post_cubit.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_comment_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_send_button.dart';

class SocialActions extends StatelessWidget {
  const SocialActions(
      {super.key,
      this.isCommentOff = true,
      required this.post,
      required this.likeAnim, });
  final PostEntity post;
  final VoidCallback likeAnim;
  final bool isCommentOff;
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
                  if (!isCommentOff) PostCommentButton(post: post),
                  if (!isCommentOff) AppSizedBox.sizedBox20W,
                  const PostSendButton()
                ],
              ),
            ],
          ),
        ),
        PostSaveButton(appUser: appUser, postId: post.postId)
      ],
    );
  }
}

class PostSaveButton extends StatefulWidget {
  const PostSaveButton(
      {super.key, required this.appUser, required this.postId});
  final AppUser appUser;
  final String postId;
  @override
  State<PostSaveButton> createState() => _PostSaveButtonState();
}

class _PostSaveButtonState extends State<PostSaveButton> {
  late bool isSaved;
  @override
  void initState() {
    super.initState();
    isSaved = widget.appUser.savedPosts.contains(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.onlyRightSmall,
      child: CustomSvgIcon(
          onTap: () {
            if (isSaved) {
              context.read<SavePostCubit>().savePost(
                  postId: widget.postId,
                  callBack: () {
                    setState(() {
                      isSaved = !isSaved;
                      widget.appUser.savedPosts.add(widget.postId);
                    });
                  });
            } else {
              context.read<SavePostCubit>().savePost(
                  postId: widget.postId,
                  callBack: () {
                    setState(() {
                      isSaved = !isSaved;
                      widget.appUser.savedPosts.remove(widget.postId);
                    });
                  });
            }
            setState(() {
              isSaved = !isSaved;
            });
          },
          assetPath: isSaved ? AppAssetsConst.saved : AppAssetsConst.save,
          height: 23,
          width: 23,
          color: isSaved ? Colors.white.withOpacity(.9) : null),
    );
  }
}
