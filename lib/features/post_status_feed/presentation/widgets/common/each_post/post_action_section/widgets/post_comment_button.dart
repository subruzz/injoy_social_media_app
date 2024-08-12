import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../../../../../core/const/app_config/app_sizedbox.dart';

class PostCommentButton extends StatefulWidget {
  const PostCommentButton({super.key, required this.post, this.isReel = false});
  final PostEntity post;
  final bool isReel;
  @override
  State<PostCommentButton> createState() => _PostCommentButtonState();
}

class _PostCommentButtonState extends State<PostCommentButton> {
  late num commentCount;
  @override
  void initState() {
    super.initState();
    commentCount = widget.post.totalComments;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return widget.isReel
          ? Column(
              children: [
                PostComment(
                    onUpdate: (commentNum) {
                      setState(() {
                        commentCount = commentNum;
                        widget.post.totalComments = commentNum;
                      });
                    },
                    post: widget.post,
                    isReel: widget.isReel),
                AppSizedBox.sizedBox5H,
                SocialActionText(
                  text: commentCount.toString(),
                )
              ],
            )
          : Row(
              children: [
                PostComment(
                    onUpdate: (commentNum) {
                      setState(() {
                        widget.post.totalComments = commentNum;

                        commentCount = commentNum;
                      });
                    },
                    post: widget.post,
                    isReel: widget.isReel),
                AppSizedBox.sizedBox5W,
                SocialActionText(
                  text: commentCount.toString(),
                )
              ],
            );
    });
  }
}

class PostComment extends StatelessWidget {
  const PostComment(
      {super.key,
      required this.onUpdate,
      required this.post,
      required this.isReel});
  final void Function(num) onUpdate;
  final PostEntity post;
  final bool isReel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // context.read<GetPostCommentCubit>().getPostComments(
          //       postId: widget.post.postId,
          //       oncommentAction: (commentNum) {
          //         //set state for scoped updated of comment length
          //         setState(() {
          //           commentCount = commentNum;
          //         });
          //       },
          //     );
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => CommentScreen(
                    isReel: isReel,
                    onCommentAction: (commentNum) {
                      onUpdate(commentNum);
                      //set state for scoped updated of comment length
                      // setState(() {
                      //   commentCount = commentNum;
                      // });
                    },
                    post: post,
                  ));
        },
        child: CustomSvgIcon(
          color: isReel ? Colors.white : null,
          assetPath: AppAssetsConst.commentIcon,
          height: isReel ? 25 : 20,
          width: isReel ? 25 : 20,
        ));
  }
}
