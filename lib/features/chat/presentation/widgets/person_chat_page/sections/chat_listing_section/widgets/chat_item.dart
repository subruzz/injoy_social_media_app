import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_bubble.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/reply_preview_widget.dart';

import '../../../../../../../../core/const/chat_const/chat_const.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    this.onTap,
    required this.isShowTick,
    this.isSeen,
    required this.isMe,
    this.onLongPress,
    required this.messageItem,
    required this.selectedMessages,
  });

  final bool isShowTick;
  final bool? isSeen;
  final MessageEntity messageItem;
  final VoidCallback? onLongPress;
  final bool isMe;
  final VoidCallback? onTap;
  final ValueNotifier<List<MessageEntity>> selectedMessages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      onLongPress: onLongPress,
      child: ValueListenableBuilder(
        valueListenable: selectedMessages,
        builder: (context, value, child) {
          final isSelected =
              value.any((msg) => msg.messageId == messageItem.messageId);

          return Container(
            color: isSelected
                ? Colors.green
                    .withOpacity(0.3) // Light background color when selected
                : Colors.transparent, // Transparent when not selected
            width: double.infinity, // Take the entire width
            child: Padding(
              padding: !isMe
                  ? AppPadding.onlyLeftMedium
                  : AppPadding.onlyRightMedium,
              child: Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: .75.sw), // Constrain the chat item width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Only when the message is a reply
                      if (messageItem.isItReply)
                        ReplyPreviewWidget(
                          messageItem: messageItem,
                          assetLink: messageItem.repliedMessageAssetLink,
                          gradient: isMe ? ChatConstants.chatGradient : null,
                          borderColor:
                              isMe ? null : AppDarkColor().softBackground,
                          color: isMe
                              ? AppDarkColor().replyMessageContainerColor
                              : AppDarkColor().secondaryBackground,
                          isReplyChat: true,
                          showBackground: !isMe,
                          message: messageItem.repliedMessage,
                          messageType: messageItem.repliedMessageType ?? '',
                          userName: messageItem.repliedTo ?? '',
                          repliedmessageCreator:
                              messageItem.repliedMessgeCreatorId ?? '',
                        ),
                      // Normal chat messages
                      ChatBubble(
                        messageItem: messageItem,
                        isMe: isMe,
                        isShowTick: isShowTick,
                        backgroundColor: isSelected
                            ? Colors.green // Front color when selected
                            : isMe
                                ? Colors
                                    .transparent // Default color for the sender
                                : AppDarkColor()
                                    .secondaryBackground, // Default color for the receiver
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
