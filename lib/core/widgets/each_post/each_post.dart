import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/post_action_section.dart';
import 'package:social_media_app/core/widgets/each_post/post_content_section/post_content_section.dart';
import 'package:social_media_app/core/widgets/each_post/post_image_section.dart/post_image_section.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/post_top_details.dart';
import 'package:social_media_app/core/widgets/web/web_helper_container.dart';

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
    this.currentPostIndex = 0,
    this.onAboutAccount,
    this.isEdit = false,
  });
  final int currentPostIndex;
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
  final _postPageController = PageController();
  bool _isAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppPadding.only(left: 15.0, right: 10, bottom: 25),
        child: isThatTabOrDeskTop
            ? WebHelperContainerWithBorder(
                lessPadding: true, child: _buildPostColumn())
            : _buildPostColumn()
        // Align(
        //   alignment: Alignment.center,
        //   child: Opacity(
        //     opacity: _isAnimating ? 1 : 0,
        //     child: LikePopupAnimation(
        //         isAnimating: _isAnimating,
        //         duration: const Duration(milliseconds: 700),
        //         child: Icon(Icons.favorite,
        //             color: AppDarkColor().buttonBackground, size: 100),
        //         onEnd: () {
        //           setState(() {
        //             _isAnimating = false;
        //           });
        //         }),
        //   ),
        // ),

        );
  }

  Widget _buildPostColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostTopDetails(
          currentPostIndex: widget.currentPostIndex,
          post: widget.currentPost,
          pagecontroller: _postPageController,
        ),
        AppSizedBox.sizedBox5W,
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ViewPost(post: widget.currentPost),
            // ));
          },
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

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostContentSection(
                hashtags: widget.currentPost.hashtags,
                postDesc: widget.currentPost.description,
              ),
              AppSizedBox.sizedBox5H,
              PostImageSection(
                postImages: widget.currentPost.postImageUrl,
                pagecontroller: _postPageController,
              ),
              isThatTabOrDeskTop
                  ? const SizedBox(
                      height: 10,
                    )
                  : AppSizedBox.sizedBox10H,
              Align(
                  alignment: Alignment.centerRight,
                  child: SocialActions(
                    isCommentOff: widget.currentPost.isCommentOff,
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
    );
  }
}
