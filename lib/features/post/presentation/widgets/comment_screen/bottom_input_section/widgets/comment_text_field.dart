import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

import '../../../../../../../core/utils/responsive/constants.dart';

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
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
        focusNode: inputNode,
        onChanged: (value) {
          onChanged(value);
        },
        autofocus: true,
        controller: commentController,
        decoration: InputDecoration(
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
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
