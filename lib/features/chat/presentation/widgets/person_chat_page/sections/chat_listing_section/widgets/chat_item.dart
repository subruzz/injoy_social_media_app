import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_audio_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_photo_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_video_widget.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key,
      required this.createAt,
      this.onSwipe,
      this.onTap,
      this.message,
      required this.messageType,
      required this.isShowTick,
      this.isSeen,
      this.rightPadding,
      required this.isMe,
      this.onLongPress,
      required this.messageItem});
  final double? rightPadding;
  final String createAt;
  final VoidCallback? onSwipe;
  final String? message;
  final String messageType;
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
                if (messageItem.repliedTo != null)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(
                        left: 5, right: isMe ? 5 : 0, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: !isMe
                          ? AppDarkColor().secondaryBackground
                          : AppDarkColor().buttonBackground,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isMe
                                      ? AppDarkColor().buttonBackground
                                      : AppDarkColor().softBackground,
                                  width: 2)),
                          color: isMe
                              ? Color.fromARGB(255, 193, 86, 102)
                              : AppDarkColor()
                                  .secondaryBackground
                                  .withOpacity(.3),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: isMe
                                      ? Color(0xFFFF9AA2)
                                      : AppDarkColor()
                                          .buttonBackground // Light Coral
                                  ,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              width: 5,
                            ),
                            // VerticalDivider(
                            //   thickness: 4,
                            //   width: 4,
                            // ),
                            AppSizedBox.sizedBox5W,
                            // if (messageItem.repliedMessageType ==
                            //         MessageTypeConst.textMessage &&
                            //     messageItem.messageType ==
                            //         MessageTypeConst.textMessage)
                            //   Column(
                            //     children: [
                            //       if (messageItem.repliedTo != null)
                            //         Text(messageItem.repliedTo!),
                            //       Text(
                            //         messageItem.message ?? '',
                            //         maxLines: 2,
                            //       ),
                            //     ],
                            //   )
                            // else
                            Builder(builder: (context) {
                              log('df');
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (messageItem.repliedTo != null)
                                          Text(
                                            messageItem.repliedTo!,
                                            style: AppTextTheme
                                                .bodyMeidumwhiteVariant
                                                .bodyMedium,
                                          ),
                                      ],
                                    ),
                                    AppSizedBox.sizedBox5H,

                                    Builder(builder: (context) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          messageItem.messageType ==
                                                  MessageTypeConst.gifMessage
                                              ? const Icon(Icons.gif)
                                              : messageItem.messageType ==
                                                      MessageTypeConst
                                                          .audioMessage
                                                  ? const Icon(
                                                      Icons.audiotrack_outlined)
                                                  : (messageItem.messageType ==
                                                                  MessageTypeConst
                                                                      .textMessage ||
                                                              messageItem
                                                                      .messageType ==
                                                                  MessageTypeConst
                                                                      .videoMessage ||
                                                              messageItem
                                                                      .messageType ==
                                                                  MessageTypeConst
                                                                      .photoMessage) &&
                                                          messageItem.message !=
                                                              null
                                                      ? Expanded(
                                                          child: Text(
                                                            messageItem
                                                                    .repliedMessage ??
                                                                '',
                                                            maxLines: 2,
                                                            style: AppTextTheme
                                                                .bodyMeidumwhiteVariant
                                                                .bodyMedium,
                                                          ),
                                                        )
                                                      : EmptyDisplay(),
                                          (messageItem.messageType ==
                                                          MessageTypeConst
                                                              .photoMessage &&
                                                      messageItem.assetPath !=
                                                          null) ||
                                                  (messageItem.messageType ==
                                                          MessageTypeConst
                                                              .gifMessage &&
                                                      messageItem.message !=
                                                          null)
                                              ? Image.network(
                                                  messageItem.messageType ==
                                                          MessageTypeConst
                                                              .gifMessage
                                                      ? messageItem.message!
                                                      : messageItem.assetLink!,
                                                  width: 30.w,
                                                )
                                              : EmptyDisplay()
                                        ],
                                      );
                                    })
                                    // : messageInfoStoreState.messageType ==
                                    //         MessageTypeConst.audioMessage
                                    //     ? Icon(Icons.audio_file)
                                    //     : EmptyDisplay()
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: messageItem.repliedTo != null ? double.infinity : null,
                  margin: messageItem.repliedTo == null
                      ? const EdgeInsets.only(top: 10)
                      : null,
                  decoration: BoxDecoration(
                    gradient: isMe
                        // &&
                        //         messageType != MessageTypeConst.photoMessage &&
                        //         messageType != MessageTypeConst.videoMessage &&
                        //         messageType != MessageTypeConst.gifMessage
                        ? const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 240, 93, 130),
                              Color(0xFFfe526a),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: !isMe
                        ? AppDarkColor().secondaryBackground
                        : AppDarkColor().softBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: !isMe || messageItem.repliedTo != null
                          ? const Radius.circular(0)
                          : Radius.circular(
                              AppBorderRadius.topLeftRadius(12),
                            ),
                      topRight: isMe || messageItem.repliedTo != null
                          ? const Radius.circular(0)
                          : Radius.circular(
                              AppBorderRadius.topLeftRadius(12),
                            ),
                      bottomLeft:
                          Radius.circular(AppBorderRadius.topLeftRadius(12)),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5,
                            right: messageType == MessageTypeConst.textMessage
                                ? 70
                                : isMe
                                    ? 5
                                    : 0,
                            top: 5,
                            bottom: 20),
                        child: messageType == MessageTypeConst.textMessage
                            ? Text(
                                message ?? '',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )
                            : (messageType == MessageTypeConst.photoMessage &&
                                        messageItem.assetLink != null) ||
                                    (messageType ==
                                            MessageTypeConst.gifMessage &&
                                        messageItem.message != null)
                                ? ChatPhotoWidget(
                                    url: messageType ==
                                            MessageTypeConst.photoMessage
                                        ? messageItem.assetLink!
                                        : messageItem.message!)
                                : messageType == MessageTypeConst.videoMessage
                                    ? Column(
                                        children: [
                                          CachedVideoMessageWidget(
                                              url: messageItem.assetLink!)
                                        ],
                                      )
                                    : ChatAudioWidget(
                                        audioUrl: messageItem.assetLink!,
                                      ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 5,
                        child: Row(
                          children: [
                            Text(
                              createAt,
                              style: AppTextTheme
                                  .bodysmallPureWhiteVariations.bodySmall,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            isShowTick == true
                                ? Icon(
                                    messageItem.isSeen == true
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
