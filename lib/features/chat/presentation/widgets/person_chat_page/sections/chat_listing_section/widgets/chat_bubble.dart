import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/utils/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/view_media.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_audio_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_photo_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_video_widget.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';

import '../../../../../../../../core/const/chat_const/chat_const.dart';
import '../../../../../../../../core/widgets/common/video_playing_widget.dart';

class ChatBubble extends StatelessWidget {
  final MessageEntity messageItem;
  final bool isMe;
  final bool isShowTick;
  final Color backgroundColor;
  const ChatBubble({
    super.key,
    required this.messageItem,
    required this.isMe,
    required this.isShowTick, required this.backgroundColor,
  });
  Gradient? _getGradient() {
    if (isMe) {
      return ChatConstants.chatGradient;
    }
    return null;
  }

  Color _getColor() {
    if (!isMe) {
      return AppDarkColor().secondaryBackground;
    }
    return AppDarkColor().softBackground;
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: !isMe || messageItem.repliedTo != null
          ? const Radius.circular(0)
          : ChatConstants.commonborderRadius12,
      topRight: isMe || messageItem.repliedTo != null
          ? const Radius.circular(0)
          : ChatConstants.commonborderRadius12,
      bottomLeft: ChatConstants.commonborderRadius12,
      bottomRight: ChatConstants.commonborderRadius12,
    );
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.only(
      left: 5.w,
      right: messageItem.messageType == MessageTypeConst.textMessage
          ? 70.w
          : isMe
              ? 5.w
              : 0,
      top: 5.h,
      bottom: 20.h,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   if (messageItem.messageType == MessageTypeConst.photoMessage ||
      //       messageItem.messageType == MessageTypeConst.videoMessage) {
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => ViewMedia(
      //         initialIndex: 0,
      //         isThatVdo:
      //             messageItem.messageType == MessageTypeConst.videoMessage,
      //         assets: [messageItem.assetLink!],
      //       ),
      //     ));
      //   }
      // },
      child: Container(
        width: messageItem.repliedTo != null ? double.infinity : null,
        margin: messageItem.repliedTo == null
            ? AppPadding.only(top: 10.h, bottom: 5.h)
            : null,
        decoration: BoxDecoration(
          gradient: _getGradient(),
          color: _getColor(),
          borderRadius: _getBorderRadius(),
        ),
        child: Stack(
          children: [
            Padding(
                padding: _getPadding(),
                child: MessageContentWidget(messageItem: messageItem)),
            Positioned(
              bottom: 4.h,
              right: 5.w,
              child: TimestampAndTickWidget(
                  messageItem: messageItem, isShowTick: isShowTick),
            ),
          ],
        ),
      ),
    );
  }
}

class TimestampAndTickWidget extends StatelessWidget {
  final MessageEntity messageItem;
  final bool isShowTick;

  const TimestampAndTickWidget({
    super.key,
    required this.messageItem,
    required this.isShowTick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (messageItem.createdAt != null)
          Text(
            messageItem.createdAt!.toDate().to12HourFormat(),
            style: AppTextTheme.getResponsiveTextTheme(context)
                .bodySmall
                ?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: isThatTabOrDeskTop ? 12 : null),
          ),
        AppSizedBox.sizedBox5W,
        // if (isShowTick)
        //   Icon(
        //     messageItem.isSeen ? Icons.done_all : Icons.done,
        //     size: isThatTabOrDeskTop ? 16 : 16.w,
        //     color: Colors.white,
        //   ),
      ],
    );
  }
}

class MessageContentWidget extends StatelessWidget {
  final MessageEntity messageItem;

  const MessageContentWidget({
    super.key,
    required this.messageItem,
  });

  @override
  Widget build(BuildContext context) {
    switch (messageItem.messageType) {
      case MessageTypeConst.textMessage:
        return Text(
          messageItem.message ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: isThatTabOrDeskTop ? 16 : null),
        );
      case MessageTypeConst.photoMessage:
        return ChatPhotoWidget(
            caption: messageItem.message, url: messageItem.assetLink!);

      case MessageTypeConst.gifMessage:
        return ChatPhotoWidget(
          url: messageItem.message!,
        );
      case MessageTypeConst.videoMessage:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: VideoPlayerWidget(
                vdo: messageItem.assetLink!,
                onlyVdo: true,
                playAndLoop: false,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewMedia(
                      initialIndex: 0,
                      isThatVdo: messageItem.messageType ==
                          MessageTypeConst.videoMessage,
                      assets: [messageItem.assetLink!],
                    ),
                  ));
                },
              ),
            ),
            Text(messageItem.message ?? '',
                style: AppTextTheme.getResponsiveTextTheme(context)
                    .labelMedium
                    ?.copyWith(color: Colors.white))
          ],
        );
      default:
        return ChatAudioWidget(audioUrl: messageItem.assetLink!);
    }
  }
}
