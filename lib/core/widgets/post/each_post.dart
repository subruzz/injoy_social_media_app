import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/animation.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/post/post_action_bar.dart';
import 'package:social_media_app/core/widgets/post/post_description.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/core/widgets/post/post_hashtag.dart';
import 'package:social_media_app/core/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/post/post_option_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_owner_username.dart';
import 'package:social_media_app/core/widgets/post/post_single_image.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_time.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_profile.dart';

class EachPost extends StatefulWidget {
  const EachPost({
    super.key,
    required this.currentPost,
    this.onShare,
    this.onSave,
    this.onHideUser,
    this.onAddToFavorite,
    this.onTurnOffCommenting,
    this.onEdit,
    this.onDelete,
    this.onAboutAccount,
    this.isEdit = false,
  });

  final bool isEdit;
  final PostEntity currentPost;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onHideUser;
  final VoidCallback? onAddToFavorite;
  final VoidCallback? onTurnOffCommenting;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAboutAccount;

  @override
  State<EachPost> createState() => _EachPostState();
}

class _EachPostState extends State<EachPost> {
  bool _isAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 25),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircularUserProfile(
                    profile: widget.currentPost.userProfileUrl,
                    size: 23,
                  ),
                  AppSizedBox.sizedBox10W,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostOwnerUsername(userName: widget.currentPost.username),
                      AppSizedBox.sizedBox5W,
                      // const PostDot(),
                      AppSizedBox.sizedBox5W,
                      PostTime(postTime: widget.currentPost.createAt.toDate()),
                    ],
                  ),
                  const Spacer(),
                  PostOptionButton(
                    isEdit: widget.isEdit,
                    onShare: widget.onShare,
                    onTurnOffCommenting: widget.onTurnOffCommenting,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                  ),
                ],
              ),
              AppSizedBox.sizedBox5W,
              GestureDetector(
                // onDoubleTap: () {
                // final currentUserId = context.read<AppUserBloc>().appUser.id;

                // setState(() {
                //   _isAnimating = true;
                //   if (!widget.currentPost.likes.contains(currentUserId)) {
                //     widget.currentPost.likes.add(currentUserId);
                //     context.read<LikePostBloc>().add(LikePostClickEvent(
                //         postId: widget.currentPost.postId,
                //         currentUserId:
                //             context.read<AppUserBloc>().appUser.id));
                //   }
                // });
                // },
                onTap: () async {
                  // context
                  //     .read<OtherProfileCubit>()
                  //     .getOtherProfile(currentPost.creatorUid);
                  final FollowunfollowCubit? res =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OtherUserProfilePage(
                        otherUserId: widget.currentPost.creatorUid,
                        userName: widget.currentPost.userFullName),
                  ));
                  if (res != null) {
                    log('follow checking');
                    if (res.state is FollowFailure ||
                        res.state is UnfollowFailure) {
                      Messenger.showSnackBar();
                    }
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostDescription(
                        description: widget.currentPost.description ?? ''),
                    if (widget.currentPost.hashtags.isNotEmpty)
                      PostHashtag(hashtags: widget.currentPost.hashtags),
                    AppSizedBox.sizedBox5H,
                    if (widget.currentPost.postImageUrl.isNotEmpty)
                      widget.currentPost.postImageUrl.length == 1
                          ? PostSingleImage(
                              imgUrl: widget.currentPost.postImageUrl[0])
                          : PostMultipleImages(
                              postImageUrls: widget.currentPost.postImageUrl),
                    if (widget.currentPost.postImageUrl.isNotEmpty)
                      AppSizedBox.sizedBox5H,
                    Align(
                        alignment: Alignment.centerRight,
                        child: SocialActions(
                          likeAnim: () {
                            setState(() {
                              _isAnimating = true;
                            });
                          },
                          post: widget.currentPost,
                        )),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: _isAnimating ? 1 : 0,
              child: LikePopupAnimation(
                  isAnimating: _isAnimating,
                  duration: const Duration(milliseconds: 700),
                  child: Icon(Icons.favorite,
                      color: AppDarkColor().buttonBackground, size: 100),
                  onEnd: () {
                    setState(() {
                      _isAnimating = false;
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
