import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/like_comment/like_comment_cubit.dart';

class EachComment extends StatelessWidget {
  const EachComment(
      {super.key,
      required this.postId,
      required this.commentId,
      required this.editCall,
      required this.comment,
      required this.myId,
      this.isCompleteView = false});
  final String postId;
  final String commentId;
  final VoidCallback editCall;
  final String myId;
  final CommentEntity comment;
  final bool isCompleteView;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPressStart: (details) async {
          if (comment.creatorId != myId) return;
          HapticFeedback.heavyImpact();
          final offset = details.globalPosition;

          showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                offset.dx,
                offset.dy,
                0,
                MediaQuery.of(context).size.height - offset.dy,
              ),
              items: [
                PopupMenuItem(
                  child: const Text('Delete'),
                  onTap: () {
                    context
                        .read<CommentBasicCubit>()
                        .deleteComment(postId: postId, commentId: commentId);
                  },
                ),
                PopupMenuItem(
                  child: const Text('Edit'),
                  onTap: () {
                    editCall();
                  },
                ),
              ]);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircularUserProfile(
                  size: isCompleteView ? 20 : 20,
                ),
                AppSizedBox.sizedBox10W,
                Expanded(
                  child: Text(
                      addAtSymbol(
                        comment.userName,
                      ),
                      style: isCompleteView
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.labelMedium),
                ),
                AppSizedBox.sizedBox10W,
                AppSizedBox.sizedBox10W,
                Expanded(child: Text(comment.createdAt.toDate().timeAgo())),
                if (comment.isEdited) const Text('(edited)')
              ],
            ),
            AppSizedBox.sizedBox5H,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Text(comment.comment)),
                AppSizedBox.sizedBox10W,
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (comment.likes.contains(myId)) {
                          comment.likes.remove(myId);
                          context.read<LikeCommentCubit>().removeLikecomment(
                              postId: comment.postId,
                              commentId: comment.commentId,
                              currentUserId: myId);
                        } else {
                          comment.likes.add(myId);
                          context.read<LikeCommentCubit>().likeComment(
                              postId: comment.postId,
                              commentId: comment.commentId,
                              currentUserId: myId);
                        }
                      },
                      child: !comment.likes.contains(myId)
                          ? const Icon(
                              Icons.favorite_border_outlined,
                            )
                          : Icon(
                              Icons.favorite,
                              color: AppDarkColor().iconSecondarycolor,
                            ),
                    ),
                    Text(comment.likes.length.toString()),
                  ],
                )
              ],
            ),
            AppSizedBox.sizedBox5H,
            // const Text('Reply')
          ],
        ),
      ),
    );
  }
}
