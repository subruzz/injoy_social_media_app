import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/sanitize_comment.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';

class CommentSumbissitionVisibilityWidget extends StatelessWidget {
  const CommentSumbissitionVisibilityWidget(
      {super.key,
      required this.commentSubmitSelection,
      required this.myId,
      required this.postId,
      required this.commentId,
      required this.commentController});
  final ValueNotifier<({bool isComment, bool isEdit, bool isTextEmpty})>
      commentSubmitSelection;
  final String myId;
  final String postId;
  final String commentId;
  final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: commentSubmitSelection,
      builder: (context, value, child) {
        return (value.isComment || value.isEdit) && !value.isTextEmpty
            ? TextButton(
                onPressed: () {
                  log('comment id is $commentId');
                  final user = context.read<AppUserBloc>().appUser;
                  commentSubmitSelection.value.isComment
                      ? context.read<CommentBasicCubit>().addComment(
                          comment: sanitizeComment(commentController.text),
                          userName: user.userName ?? '',
                          postId: postId,
                          creatorId: user.id)
                      : commentId.isNotEmpty
                          ? context.read<CommentBasicCubit>().updateComment(
                                postId: postId,
                                commentId: commentId,
                                comment:
                                    sanitizeComment(commentController.text),
                              )
                          : null;
                  // inputNode?.unfocus();
                  commentSubmitSelection.value =
                      (isComment: false, isEdit: false, isTextEmpty: true);
                  commentController.clear();
                },
                child: Text(
                  value.isComment ? 'Post' : 'Edit',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge, // Button text color
                ),
              )
            : const EmptyDisplay();
      },
    );
  }
}
