import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';

import '../../../../../../../core/theme/color/app_colors.dart';
import '../../../../bloc/comment_cubits/like_comment/like_comment_cubit.dart';

class CommentLikeSection extends StatefulWidget {
  const CommentLikeSection(
      {super.key, required this.comment, required this.myId});
  final CommentEntity comment;
  final String myId;

  @override
  State<CommentLikeSection> createState() => _CommentLikeSectionState();
}

class _CommentLikeSectionState extends State<CommentLikeSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.onlyTopSmall,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (widget.comment.likes.contains(widget.myId)) {
                widget.comment.likes.remove(widget.myId);
                context.read<LikeCommentCubit>().removeLikecomment(
                    postId: widget.comment.postId,
                    commentId: widget.comment.commentId,
                    currentUserId: widget.myId);
              } else {
                widget.comment.likes.add(widget.myId);
                context.read<LikeCommentCubit>().likeComment(
                    postId: widget.comment.postId,
                    commentId: widget.comment.commentId,
                    currentUserId: widget.myId);
              }
              setState(() {});
            },
            child: !widget.comment.likes.contains(widget.myId)
                ? Icon(
                    color: AppDarkColor().iconSecondarycolor,
                    Icons.favorite_border_outlined,
                    size: 20.w,
                  )
                : Icon(
                    Icons.favorite,
                    size: 20.w,
                    color: AppDarkColor().iconSoftColor,
                  ),
          ),
          Text(
            widget.comment.likes.length.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
