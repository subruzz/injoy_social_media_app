import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/pages/person_chat_page.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_audio_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_photo_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_video_widget.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key,
      required this.createAt,
      this.onSwipe,
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !isMe ? AppPadding.onlyLeftMedium : AppPadding.onlyRightMedium,
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: .8.sw),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              gradient: isMe &&
                      messageType != MessageTypeConst.photoMessage &&
                      messageType != MessageTypeConst.videoMessage
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
                topLeft: !isMe
                    ? const Radius.circular(0)
                    : Radius.circular(
                        AppBorderRadius.topLeftRadius(12),
                      ),
                topRight: isMe
                    ? const Radius.circular(0)
                    : Radius.circular(
                        AppBorderRadius.topLeftRadius(12),
                      ),
                bottomLeft: Radius.circular(AppBorderRadius.topLeftRadius(12)),
                bottomRight: const Radius.circular(12),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: messageType == MessageTypeConst.textMessage
                          ? 70
                          : isMe
                              ? 5
                              : 0,
                      top: 10,
                      bottom: 20),
                  child: messageType == MessageTypeConst.textMessage
                      ? Text(
                          message ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      : messageType == MessageTypeConst.photoMessage &&
                              messageItem.assetLink != null
                          ? ChatPhotoWidget(url: messageItem.assetLink!)
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
                        style:
                            AppTextTheme.bodysmallPureWhiteVariations.bodySmall,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick == true
                          ? Icon(
                              isSeen == true ? Icons.done_all : Icons.done,
                              size: 16,
                              color: isSeen == true ? Colors.blue : Colors.grey,
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // Padding(
    //   padding: AppPadding.small,
    //   child: GestureDetector(
    //     onLongPress: onLongPress,
    //     child: Align(
    //       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    //       child: Column(
    //         // crossAxisAlignment: alignment == Alignment.centerRight
    //         //     ? CrossAxisAlignment.end
    //         //     : CrossAxisAlignment.start,
    //         children: [
    //           Column(
    //             // crossAxisAlignment: alignment == Alignment.centerRight
    //             //     ? CrossAxisAlignment.end
    //             //     : CrossAxisAlignment.start,
    //             children: [
    //               Builder(
    //                 builder: (context) {
    //                   return Container(
    //                     margin: AppPadding.onlyTopSmall,
    //                     constraints: BoxConstraints(
    //                       maxWidth: MediaQuery.of(context).size.width * 0.80,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       gradient: isMe
    //                           ? const LinearGradient(
    //                               colors: [
    //                                 Color(0xFFFf6b81),

    //                                 Color(0xFFFf5b73),
    //                               ],
    //                               begin: Alignment
    //                                   .topLeft,
    //                               end: Alignment
    //                                   .bottomRight,
    //                             )
    //                           : null,
    //                       color:
    //                           !isMe ? AppDarkColor().secondaryBackground : null,
    //                       borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(
    //                             AppBorderRadius.topLeftRadius(12)),
    //                         topRight: Radius.circular(
    //                             AppBorderRadius.topLeftRadius(12)),
    //                         bottomLeft: isMe
    //                             ? Radius.circular(
    //                                 AppBorderRadius.topLeftRadius(12))
    //                             : const Radius.circular(0),
    //                         bottomRight: isMe
    //                             ? const Radius.circular(0)
    //                             : Radius.circular(
    //                                 AppBorderRadius.topLeftRadius(12)),
    //                       ),
    //                     ),
    //                     child: Column(
    //                       crossAxisAlignment:
    //                           messageType == MessageTypeConst.textMessage
    //                               ? CrossAxisAlignment.start
    //                               : CrossAxisAlignment.end,
    //                       children: [
    //                         messageType == MessageTypeConst.textMessage
    //                             ? Padding(
    //                                 padding: EdgeInsets.only(
    //                                   left: 5,
    //                                   right: messageType ==
    //                                           MessageTypeConst.textMessage
    //                                       ? 50
    //                                       : 5,
    //                                   top: 5,
    //                                   bottom: 5,
    //                                 ),
    //                                 child: Text(
    //                                   message ?? '',
    //                                   style:
    //                                       Theme.of(context).textTheme.bodyLarge,
    //                                 ),
    //                               )
    //                             : messageType == MessageTypeConst.photoMessage
    //                                 ? Column(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     children: [
    //                                       CachedNetworkImage(
    //                                           imageUrl: messageItem.assetLink!),
    //                                       if (messageItem.message != null &&
    //                                           messageItem.message!.isNotEmpty)
    //                                         Text(
    //                                           messageItem.message!,
    //                                           style: AppTextTheme
    //                                               .bodysmallPureWhiteVariations
    //                                               .bodySmall,
    //                                         )
    //                                     ],
    //                                   )
    //                                 : messageType ==
    //                                         MessageTypeConst.videoMessage
    //                                     ? Column(
    //                                         children: [
    //                                           CachedVideoMessageWidget(
    //                                               url: messageItem.assetLink!),
    //                                           Text(messageItem.message ?? '')
    //                                         ],
    //                                       )
    //                                     : MessageAudioWidget(
    //                                         audioUrl: messageItem.assetLink!,
    //                                       ),
    //                         Row(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             AppSizedBox.sizedBox20W,
    //                             Text(
    //                               createAt,
    //                               style: AppTextTheme
    //                                   .bodysmallPureWhiteVariations.bodySmall,
    //                             ),
    //                             const SizedBox(width: 5),
    //                             if (isShowTick == true)
    //                               Icon(
    //                                 isSeen == true
    //                                     ? Icons.done_all
    //                                     : Icons.done,
    //                                 size: 16,
    //                                 color: AppDarkColor().primaryText,
    //                               ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //               const SizedBox(height: 3),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    //  Padding(
    //   padding: AppPadding.small,
    //   child: GestureDetector(
    //     onLongPress: onLongPress,
    //     child: Align(
    //       alignment: alignment ?? Alignment.centerRight,
    //       child: Container(
    //         constraints: BoxConstraints(
    //           maxWidth: MediaQuery.of(context).size.width * 0.8,
    //         ),
    //         margin: AppPadding.onlyTopSmall,
    //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //         decoration: BoxDecoration(
    //           color: alignment == Alignment.centerRight
    //               ? Colors.pinkAccent.shade100
    //               : Colors.grey.shade800,
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(16),
    //             topRight: Radius.circular(16),
    //             bottomLeft: alignment == Alignment.centerRight
    //                 ? Radius.circular(16)
    //                 : Radius.circular(0),
    //             bottomRight: alignment == Alignment.centerRight
    //                 ? Radius.circular(0)
    //                 : Radius.circular(16),
    //           ),
    //         ),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             if (messageType == MessageTypeConst.textMessage)
    //               Text(
    //                 message ?? '',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               )
    //             else
    //               MessageAudioWidget(
    //                 audioUrl: message,
    //               ),
    //             const SizedBox(height: 3),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Text(
    //                   createAt,
    //                   style: TextStyle(
    //                     color: Colors.white70,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 const SizedBox(width: 5),
    //                 if (isShowTick)
    //                   Icon(
    //                     Icons.done,
    //                     size: 16,
    //                     color: Colors.white70,
    //                   ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Container(

//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: 4.5,
//                   decoration: BoxDecoration(
//                       color: reply.username ==
//                               widget.message.recipientName
//                           ? Colors.deepPurpleAccent
//                           : tabColor,
//                       borderRadius:
//                           const BorderRadius.only(
//                               topLeft:
//                                   Radius.circular(15),
//                               bottomLeft:
//                                   Radius.circular(15))),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 5.0, vertical: 5),
//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${reply.username == widget.message.recipientName ? reply.username : "You"}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: reply.username ==
//                                       widget.message
//                                           .recipientName
//                                   ? Colors
//                                       .deepPurpleAccent
//                                   : tabColor),
//                         ),
//                         MessageReplayTypeWidget(
//                           message: reply.message,
//                           type: reply.messageType,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//     const SizedBox(
//       height: 3,
//     ),
//     MessageTypeWidget(
//       message: message,
//       type: messageType,
//     ),
//   ],
// ),
