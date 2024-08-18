import 'package:flutter/material.dart';

class SelectEmojiItem extends StatelessWidget {
  const SelectEmojiItem(
      {super.key,
      required this.controller,
      required this.emoji,
      required this.addToTextController});
  final TextEditingController controller;
  final String emoji;
  final VoidCallback addToTextController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          addToTextController();

          controller.text = controller.text + emoji;
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
          // setState(() {
          //   widget.textController.text = widget.textController.text + emoji;
          //   widget.textController.selection = TextSelection.fromPosition(
          //       TextPosition(offset: widget.textController.text.length));
          // });
        },
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
