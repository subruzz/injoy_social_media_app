import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField(
      {super.key,
      this.inputNode,
      required this.onChanged,
      required this.commentController});
  final FocusNode? inputNode;
  final Function(String value) onChanged;
  final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: inputNode,
        onChanged: (value) {
          onChanged(value);
        },
        autofocus: true,
        controller: commentController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppDarkColor().secondaryBackground,
          border: InputBorder.none,
          hintText: 'Write a comment...',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
