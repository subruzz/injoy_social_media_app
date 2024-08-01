import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen_builder.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../../../init_dependecies.dart';
import '../../../../../../../post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';

class PostCommentButton extends StatefulWidget {
  const PostCommentButton({super.key, required this.post});
  final PostEntity post;
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
      return Row(
        children: [
          GestureDetector(
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
                          onCommentAction: (commentNum) {
                            //set state for scoped updated of comment length
                            setState(() {
                              commentCount = commentNum;
                            });
                          },
                          post: widget.post,
                        ));
              },
              child: const CustomSvgIcon(
                assetPath: AppAssetsConst.commentIcon,
                height: 20,
                width: 20,
              )),
          AppSizedBox.sizedBox5W,
          SocialActionText(
            text: commentCount.toString(),
          )
        ],
      );
    });
  }
}
