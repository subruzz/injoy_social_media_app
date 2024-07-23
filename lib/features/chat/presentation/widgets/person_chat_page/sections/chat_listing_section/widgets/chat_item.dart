import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_bubble.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/reply_preview_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key,
      this.onTap,
      required this.isShowTick,
      this.isSeen,
      required this.isMe,
      this.onLongPress,
      required this.messageItem});

  final bool isShowTick;
  final bool? isSeen;
  final MessageEntity messageItem;
  final VoidCallback? onLongPress;
  final bool isMe;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: !isMe ? AppPadding.onlyLeftMedium : AppPadding.onlyRightMedium,
        child: Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: .75.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //only when the message is a reply
                if (messageItem.repliedTo != null)
                  ReplyPreviewWidget(
                    assetLink: messageItem.repliedMessageAssetLink,
                    gradient: isMe ? ChatConstants.chatGradient : null,
                    borderColor: isMe ? null : AppDarkColor().softBackground,
                    color: isMe
                        ? AppDarkColor().replyMessageContainerColor
                        : AppDarkColor().secondaryBackground,
                    isReplyChat: true,
                    showBackground: !isMe,
                    message: messageItem.repliedMessage,
                    messageType: messageItem.repliedMessageType ?? '',
                    userName: messageItem.repliedTo ?? '',
                  ),
                  //normal chat messages
                ChatBubble(
                    messageItem: messageItem,
                    isMe: isMe,
                    isShowTick: isShowTick)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
