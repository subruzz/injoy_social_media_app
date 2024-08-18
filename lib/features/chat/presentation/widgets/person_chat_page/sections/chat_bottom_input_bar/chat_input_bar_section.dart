import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_bottom_input_bar/widgets/chat_input_field.dart';

class ChatInputBarSection extends StatelessWidget {
  const ChatInputBarSection({
    super.key,
    required this.messageController,
    required this.showAttachWindow,
    required this.sendMessage,
    required this.toggleButton,
    required this.focusNode,
  });

  final FocusNode focusNode;
  final TextEditingController messageController;
  final ValueNotifier<bool> showAttachWindow;
  final ValueNotifier<bool> toggleButton;
  final VoidCallback? sendMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: isThatTabOrDeskTop
                ? MediaQuery.of(context).size.width * .3
                : .8.sw,
            child: ChatInputField(
              messageController: messageController,
              showAttachWindow: showAttachWindow,
              toggleButton: toggleButton,
              focusNode: focusNode,
            ),
          ),
        ],
      ),
    );
  }
}
