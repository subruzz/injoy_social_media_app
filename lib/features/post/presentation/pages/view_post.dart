import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/comment_bottom_input_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/each_comment.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/widgets/no_comment_display.dart';
import 'package:social_media_app/features/post/presentation/widgets/view_posts/sections/post_details_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/view_posts/sections/post_user_details_section.dart';

class ViewPost extends StatefulWidget {
  final PostEntity post;
  const ViewPost(
      {super.key, required this.post, this.isEdit = false, this.postId});
  final bool isEdit;
  final String? postId;
  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  void initState() {
    context
        .read<GetPostCommentCubit>()
        .getPostComments(postId: widget.post.postId);
    super.initState();
  }

  final FocusNode? inputNode = FocusNode();

  final TextEditingController _commentController = TextEditingController();
  final ValueNotifier<
          ({
            bool isComment,
            bool isEdit,
            bool isTextEmpty,
          })> _commentSubmitSelection =
      ValueNotifier((isComment: false, isEdit: false, isTextEmpty: true));
  String commentId = '';

  @override
  Widget build(BuildContext context) {
    final appUser = context.read<AppUserBloc>().appUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostUserDetailsSection(
                    post: widget.post,
                    isEdit: widget.isEdit,
                  ),
                  AppSizedBox.sizedBox10H,
                  PostDetailsSection(post: widget.post),
                  if (!widget.post.isCommentOff)
                    BlocBuilder<GetPostCommentCubit, GetPostCommentState>(
                      builder: (context, state) {
                        if (state is GetPostCommentSuccess) {
                          return state.postComments.isEmpty
                              ? const NoCommentDisplay()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.postComments.length,
                                  itemBuilder: (context, index) {
                                    final comment = state.postComments[index];

                                    return EachComment(
                                        creatorId: widget.post.creatorUid,
                                        postId: widget.post.postId,
                                        commentId: comment.commentId,
                                        editCall: () {
                                          inputNode?.requestFocus();
                                          _commentController.text =
                                              comment.comment;
                                          commentId = comment.commentId;
                                          _commentSubmitSelection.value = (
                                            isComment: false,
                                            isEdit: true,
                                            isTextEmpty: false
                                          );
                                        },
                                        comment: comment,
                                        myId: appUser.id);
                                  });
                        }
                        return const EmptyDisplay();
                      },
                    ),
                  if (!widget.post.isCommentOff)
                    Row(
                      children: [
                        _buildIconWithCount(Icons.favorite, 435, Colors.red),
                        AppSizedBox.sizedBox10W,
                        TextButton(
                            onPressed: () {}, child: const Text('Reply')),
                        AppSizedBox.sizedBox10W,
                      ],
                    ),
                ],
              ),
            ),
          ),
          if (!widget.post.isCommentOff)
            CommentBottomInputSection(
                creatorId: widget.post.creatorUid,
                commentController: _commentController,
                commentSubmitSelection: _commentSubmitSelection,
                myId: appUser.id,
                postId: widget.post.postId,
                commentId: commentId)
        ],
      ),
    );
  }
}

Widget _buildIconWithCount(IconData icon, int count, [Color? iconColor]) {
  return Row(
    children: [
      Icon(
        icon,
        size: 18,
        color: iconColor ?? Colors.white,
      ),
      const SizedBox(width: 5),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    ],
  );
}
