import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/sanitize_comment.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/like_comment/like_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';

class SocialActions extends StatelessWidget {
  const SocialActions({super.key, required this.post, required this.likeAnim});
  final PostEntity post;
  final VoidCallback likeAnim;

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<LikePostBloc, LikePostState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (post.likes.contains(appUser.id)) {
                              post.likes.remove(appUser.id);

                              context.read<LikePostBloc>().add(
                                  UnlikePostClickEvent(
                                      postId: post.postId,
                                      currentUserId: appUser.id));
                            } else {
                              likeAnim();
                              post.likes.add(appUser.id);
                              context.read<LikePostBloc>().add(
                                  LikePostClickEvent(
                                      postId: post.postId,
                                      currentUserId: appUser.id));
                            }
                          },
                          child: Icon(
                              size: 25,
                              post.likes.contains(appUser.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post.likes.contains(appUser.id)
                                  ? AppDarkColor().iconSecondarycolor
                                  : AppDarkColor().iconSoftColor)),
                      AppSizedBox.sizedBox5W,
                      Text(
                        post.likes.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
              // Comments
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<GetPostCommentCubit>()
                          .getPostComments(postId: post.postId);
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => CommentsBottomSheet(
                                postId: post.postId,
                              ));
                    },
                    child: SvgPicture.asset(
                      width: 24,
                      height: 24,
                      'assets/svgs/comment.svg',
                      colorFilter: ColorFilter.mode(
                        AppDarkColor().iconSoftColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  AppSizedBox.sizedBox5W,
                  Text(
                    post.totalComments.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset(
                    width: 25,
                    height: 25,
                    'assets/svgs/send.svg',
                    colorFilter: ColorFilter.mode(
                      AppDarkColor().iconSoftColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_add_outlined,
              size: 25,
              color: AppDarkColor().iconSoftColor,
            ))
        // Save
      ],
    );
  }
}

Widget textOfEmoji(
  String emoji,
  TextEditingController controller,
) {
  return GestureDetector(
    onTap: () {
      controller.text = controller.text + emoji;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      log(controller.text);
      // setState(() {
      //   widget.textController.text = widget.textController.text + emoji;
      //   widget.textController.selection = TextSelection.fromPosition(
      //       TextPosition(offset: widget.textController.text.length));
      // });
    },
    child: Text(
      emoji,
      style: TextStyle(fontSize: 22),
    ),
  );
}

class CommentsBottomSheet extends StatefulWidget {
  const CommentsBottomSheet({
    super.key,
    required this.postId,
  });
  final String postId;

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final FocusNode? inputNode = FocusNode();

  final TextEditingController _commentController = TextEditingController();
  String commentId = '';
  final ValueNotifier<
      ({
        bool isComment,
        bool isEdit,
      })> _commentSubmitSelection = ValueNotifier((
    isComment: false,
    isEdit: false,
  ));

  @override
  Widget build(BuildContext context) {
    final appUser = context.read<AppUserBloc>().appUser;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return BlocConsumer<GetPostCommentCubit, GetPostCommentState>(
          builder: (context, state) {
            if (state is GetPostCommentSuccess) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom:
                              60.0), // Adjust the bottom padding to fit the text field
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),

                        controller:
                            scrollController, // Use the scroll controller
                        itemCount: state.postComments.length,
                        itemBuilder: (context, index) {
                          final comment = state.postComments[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onLongPressStart: (details) async {
                                HapticFeedback.heavyImpact();
                                final offset = details.globalPosition;

                                showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                      offset.dx,
                                      offset.dy,
                                      0,
                                      MediaQuery.of(context).size.height -
                                          offset.dy,
                                    ),
                                    items: [
                                      PopupMenuItem(
                                        child: Text('Delete'),
                                        onTap: () {
                                          context
                                              .read<CommentBasicCubit>()
                                              .deleteComment(
                                                  postId: widget.postId,
                                                  commentId: comment.commentId);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text('Edit'),
                                        onTap: () {
                                          inputNode?.requestFocus();

                                          _commentController.text =
                                              comment.comment;
                                          commentId = comment.commentId;
                                          _commentSubmitSelection.value = (
                                            isComment: false,
                                            isEdit: true,
                                          );
                                        },
                                      ),
                                    ]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircularUserProfile(
                                        size: 20,
                                      ),
                                      AppSizedBox.sizedBox10W,
                                      Text(
                                        addAtSymbol(comment.userName),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppDarkColor()
                                                    .primaryTextBlur),
                                      ),
                                      AppSizedBox.sizedBox10W,
                                      Text(
                                          comment.createdAt.toDate().timeAgo()),
                                      if (comment.isEdited) Text('(edited)')
                                    ],
                                  ),
                                  AppSizedBox.sizedBox5H,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(child: Text(comment.comment)),
                                      AppSizedBox.sizedBox10W,
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (comment.likes
                                                  .contains(appUser.id)) {
                                                comment.likes
                                                    .remove(appUser.id);
                                                context
                                                    .read<LikeCommentCubit>()
                                                    .removeLikecomment(
                                                        postId: comment.postId,
                                                        commentId:
                                                            comment.commentId,
                                                        currentUserId:
                                                            appUser.id);
                                              } else {
                                                comment.likes.add(appUser.id);
                                                context
                                                    .read<LikeCommentCubit>()
                                                    .likeComment(
                                                        postId: comment.postId,
                                                        commentId:
                                                            comment.commentId,
                                                        currentUserId:
                                                            appUser.id);
                                              }
                                            },
                                            child: !comment.likes
                                                    .contains(appUser.id)
                                                ? Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                  )
                                                : Icon(
                                                    Icons.favorite,
                                                    color: AppDarkColor()
                                                        .iconSecondarycolor,
                                                  ),
                                          ),
                                          Text(comment.likes.length.toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                  AppSizedBox.sizedBox5H,
                                  Text('Reply')
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 80,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        color: AppDarkColor().secondaryBackground,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                textOfEmoji('❤', _commentController),
                                textOfEmoji('🙌', _commentController),
                                textOfEmoji('🔥', _commentController),
                                textOfEmoji('👏🏻', _commentController),
                                textOfEmoji('😢', _commentController),
                                textOfEmoji('😍', _commentController),
                                textOfEmoji('😮', _commentController),
                                textOfEmoji('😂', _commentController),
                              ],
                            ),
                            Row(
                              children: [
                                CircularUserProfile(
                                  size: 12,
                                ),
                                Expanded(
                                  child: TextField(
                                    focusNode:
                                        _commentSubmitSelection.value.isEdit
                                            ? inputNode
                                            : null,
                                    onChanged: (value) {
                                      _commentSubmitSelection.value = (
                                        isComment: value.isNotEmpty &&
                                            !_commentSubmitSelection
                                                .value.isEdit,
                                        isEdit:
                                            _commentSubmitSelection.value.isEdit
                                                ? true
                                                : false
                                      );
                                    },
                                    autofocus: true,
                                    controller: _commentController,
                                    style: TextStyle(
                                        color: Colors.white), // Text color
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          AppDarkColor().secondaryBackground,
                                      border: InputBorder.none,
                                      hintText: 'Write a comment...',
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder
                                          .none, // No border when focused
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ValueListenableBuilder(
                                  valueListenable: _commentSubmitSelection,
                                  builder: (context, value, child) {
                                    return value.isComment || value.isEdit
                                        ? TextButton(
                                            onPressed: () {
                                              final user = context
                                                  .read<AppUserBloc>()
                                                  .appUser;
                                              _commentSubmitSelection
                                                      .value.isComment
                                                  ? context
                                                      .read<CommentBasicCubit>()
                                                      .addComment(
                                                          comment: sanitizeComment(
                                                              _commentController
                                                                  .text),
                                                          userName:
                                                              user.userName ??
                                                                  '',
                                                          postId: widget.postId,
                                                          creatorId: user.id)
                                                  : commentId.isNotEmpty
                                                      ? context
                                                          .read<
                                                              CommentBasicCubit>()
                                                          .updateComment(
                                                            postId:
                                                                widget.postId,
                                                            commentId:
                                                                commentId,
                                                            comment:
                                                                sanitizeComment(
                                                                    _commentController
                                                                        .text),
                                                          )
                                                      : null;
                                              // inputNode?.unfocus();
                                              _commentSubmitSelection.value = (
                                                isComment: false,
                                                isEdit: false
                                              );
                                              _commentController.clear();
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
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is GetPostCommentFailure) {
              return Center(
                child: Text(state.erroMsg),
              );
            }
            return const Center(
              child: CircularLoading(),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }
}
