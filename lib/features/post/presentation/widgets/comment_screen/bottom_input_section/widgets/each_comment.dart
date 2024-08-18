import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/widgets/common/expandable_text.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/comment_like_section.dart';

class EachComment extends StatelessWidget {
  const EachComment(
      {super.key,
      required this.postId,
      required this.commentId,
      required this.editCall,
      required this.comment,
      required this.commentBasicCubit,
      required this.myId,
      this.isCompleteView = false,
      required this.creatorId,
      required this.isReel});
  final String postId;
  final String commentId;
  final VoidCallback editCall;
  final String myId;
  final String creatorId;
  final CommentEntity comment;
  final bool isCompleteView;
  final bool isReel;
  final CommentBasicCubit commentBasicCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isThatTabOrDeskTop
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 8)
          : AppPadding.symmetric(vertical: 15, horizontal: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPressStart: (details) async {
          log(comment.creatorId);
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
                    commentBasicCubit.deleteComment(
                        isReel: isReel,
                        postId: postId,
                        commentId: commentId,
                        myId: myId,
                        otherId: creatorId);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularUserProfile(
                        size: 23,
                        profile: comment.userProfile,
                      ),
                      AppSizedBox.sizedBox15W,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    addAtSymbol(
                                      comment.userName,
                                    ),
                                    style: isCompleteView
                                        ? Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: isThatTabOrDeskTop
                                                    ? 15
                                                    : null)
                                        : Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontSize: isThatTabOrDeskTop
                                                    ? 12
                                                    : null),
                                  ),
                                ),
                                AppSizedBox.sizedBox15W,
                                Flexible(
                                  child: Text(
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontSize: isThatTabOrDeskTop
                                                  ? 12
                                                  : null),
                                      '${comment.createdAt.toDate().timeAgo()} ${comment.isEdited ? '(edited)' : ''}'),
                                ),
                              ],
                            ),
                            AppSizedBox.sizedBox5H,
                            ExpandableText(
                              text: comment.comment,
                              trimLines: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CommentLikeSection(
                  comment: comment,
                  myId: myId,
                  isReel: isReel,
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
