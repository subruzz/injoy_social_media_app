import 'package:flutter/material.dart';
import 'package:social_media_app/features/post/presentation/widgets/comment_screen/bottom_input_section/widgets/emoji.dart';

class EmojiPicker extends StatelessWidget {
  final TextEditingController commentController;
  final ValueNotifier<({bool isComment, bool isEdit, bool isTextEmpty})>
      commentSubmitSelection;
  const EmojiPicker({
    super.key,
    required this.commentController,
    required this.commentSubmitSelection,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> emojis = [
      '❤',
      '🙌',
      '🔥',
      '👏🏻',
      '😢',
      '😍',
      '😮',
      '😂'
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: emojis.map((emoji) {
        return SelectEmojiItem(
          addToTextController: () {
            if (commentController.text.isEmpty) {
              commentSubmitSelection.value =
                  (isComment: true, isEdit: false, isTextEmpty: false);
            }
          },
          emoji: emoji,
          controller: commentController,
        );
      }).toList(),
    );
  }
}
