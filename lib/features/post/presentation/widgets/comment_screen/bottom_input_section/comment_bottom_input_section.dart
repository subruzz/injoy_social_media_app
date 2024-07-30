import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/comment_sumbissition_visibility_widget.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/comment_text_field.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/emoji_picker.dart';

import '../../../../../../core/theme/color/app_colors.dart';

class CommentBottomInputSection extends StatelessWidget {
  const CommentBottomInputSection(
      {super.key,
      required this.commentController,
      required this.commentSubmitSelection,
      this.inputNode,
      required this.myId,
      required this.creatorId,
      required this.postId,
      required this.commentId});
  final TextEditingController commentController;
  final ValueNotifier<({bool isComment, bool isEdit, bool isTextEmpty})>
      commentSubmitSelection;
  final FocusNode? inputNode;
  final String creatorId;
  final String myId;
  final String postId;
  final String commentId;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 70.h,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: AppDarkColor().secondaryBackground,
        child: Column(
          children: [
            EmojiPicker(
              commentController: commentController,
              commentSubmitSelection: commentSubmitSelection,
            ),
            Row(
              children: [
                const CircularUserProfile(
                  size: 12,
                ),
                CommentTextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        commentSubmitSelection.value = (
                          isComment: commentSubmitSelection.value.isComment,
                          isEdit: commentSubmitSelection.value.isEdit,
                          isTextEmpty: true,
                        );
                        return;
                      }
                      commentSubmitSelection.value = (
                        isComment: value.isNotEmpty &&
                            !commentSubmitSelection.value.isEdit,
                        isEdit:
                            commentSubmitSelection.value.isEdit ? true : false,
                        isTextEmpty: false,
                      );
                    },
                    commentController: commentController),
                AppSizedBox.sizedBox10H,
                CommentSumbissitionVisibilityWidget(
                    creatorId: creatorId,
                    commentSubmitSelection: commentSubmitSelection,
                    myId: myId,
                    postId: postId,
                    commentId: commentId,
                    commentController: commentController)
              ],
            ),
          ],
        ),
      ),
    );
  }
}