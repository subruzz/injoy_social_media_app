import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/post_action_section.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/comment_bottom_input_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/each_comment.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/widgets/no_comment_display.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen(
      {super.key,
      this.isReel = false,
      required this.post,
      required this.onCommentAction});
  final PostEntity post;
  final void Function(num) onCommentAction;
  final bool isReel;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _commentBasic = serviceLocator<CommentBasicCubit>();
  final _readComment = serviceLocator<GetPostCommentCubit>();
  @override
  void initState() {
    _readComment.getPostComments(
        isReel: widget.isReel,
        postId: widget.post.postId,
        oncommentAction: widget.onCommentAction);
    super.initState();
  }

  @override
  void dispose() {
    inputNode?.dispose();
    _commentController.dispose();
    _commentBasic.close();
    _readComment.close();
    super.dispose();
  }

  final FocusNode? inputNode = FocusNode();

  final TextEditingController _commentController = TextEditingController();
  String commentId = '';
  final ValueNotifier<
          ({
            bool isComment,
            bool isEdit,
            bool isTextEmpty,
          })> _commentSubmitSelection =
      ValueNotifier((isComment: false, isEdit: false, isTextEmpty: true));

  @override
  Widget build(BuildContext context) {
    final appUser = context.read<AppUserBloc>().appUser;
    return BlocListener<CommentBasicCubit, CommentBasicState>(
      bloc: _commentBasic,
      listenWhen: (previous, current) =>
          current is CommentDeletedSuccess || current is CommentAddedSuccess,
      listener: (context, state) {},
      child: isThatTabOrDeskTop
          ? _getComments(appUser, null)
          : DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return _getComments(appUser, scrollController);
              },
            ),
    );
  }

  Widget _getComments(AppUser user, ScrollController? controller) {
    return BlocConsumer<GetPostCommentCubit, GetPostCommentState>(
      bloc: _readComment,
      builder: (context, state) {
        if (state is GetPostCommentSuccess) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: isThatTabOrDeskTop
                    ? 0
                    : MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: isThatTabOrDeskTop ? 0 : 60.0),
                  child: state.postComments.isEmpty
                      ? const NoCommentDisplay()
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),

                          controller: controller, // Use the scroll controller
                          itemCount: state.postComments.length,
                          itemBuilder: (context, index) {
                            final comment = state.postComments[index];
                            return EachComment(
                                isReel: widget.isReel,
                                commentBasicCubit: _commentBasic,
                                creatorId: widget.post.creatorUid,
                                postId: widget.post.postId,
                                commentId: comment.commentId,
                                editCall: () {
                                  inputNode?.requestFocus();

                                  _commentController.text = comment.comment;
                                  commentId = comment.commentId;
                                  _commentSubmitSelection.value = (
                                    isComment: false,
                                    isEdit: true,
                                    isTextEmpty: false
                                  );
                                },
                                comment: comment,
                                myId: user.id);
                          },
                        ),
                ),
                if (isThatTabOrDeskTop)
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          color: AppDarkColor().secondaryBackground,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15,top: 10, bottom: 70.0),
                            child: SocialActions(
                                post: widget.post, likeAnim: () {}),
                          ))),
                CommentBottomInputSection(
                    isReel: widget.isReel,
                    commentBasicCubit: _commentBasic,
                    creatorId: widget.post.creatorUid,
                    commentController: _commentController,
                    commentSubmitSelection: _commentSubmitSelection,
                    myId: user.id,
                    postId: widget.post.postId,
                    commentId: commentId)
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
          child: CircularLoadingGrey(),
        );
      },
      listener: (context, state) {},
    );
  }
}
