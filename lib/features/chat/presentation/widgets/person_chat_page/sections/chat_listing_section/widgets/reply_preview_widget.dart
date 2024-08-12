import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_side_bar.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class ReplyPreviewWidget extends StatelessWidget {
  final String messageType;
  final String userName;
  final bool isReplyChat;
  final Color? color;
  final MessageEntity? messageItem;
  final String? message;
  final bool showIcon;
  final Color? borderColor;
  final String? assetLink;
  final Gradient? gradient;
  final String? repliedmessageCreator;
  final bool showBackground;
  const ReplyPreviewWidget(
      {super.key,
      this.color,
      this.messageItem,
      this.repliedmessageCreator,
      required this.assetLink,
      this.borderColor,
      this.gradient,
      this.showBackground = true,
      this.showIcon = false,
      this.message,
      required this.messageType,
      required this.userName,
      this.isReplyChat = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.onlyTopSmall,
      padding: isReplyChat ? AppPadding.small : AppPadding.medium,
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border(
            bottom:
                BorderSide(color: borderColor ?? Colors.transparent, width: 2)),
        color: color ?? AppDarkColor().softBackground,
        borderRadius: BorderRadius.only(
          topLeft: isReplyChat
              ? ChatConstants.commonborderRadius12
              : ChatConstants.commonborderRadius24,
          topRight: isReplyChat
              ? ChatConstants.commonborderRadius12
              : ChatConstants.commonborderRadius24,
        ),
      ),
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: AppBorderRadius.small,
              color: showBackground
                  ? AppDarkColor().softBackground
                  : const Color.fromARGB(255, 141, 73, 96)),
          child: Row(
            children: [
              const ChatSideBar(),
              AppSizedBox.sizedBox5W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(builder: (context) {
                      log('check if ${repliedmessageCreator == context.read<AppUserBloc>().appUser.id}');
                      return HeaderRow(
                        userName: !isReplyChat
                            ? userName
                            : (isReplyChat && messageItem != null)
                                ? (messageItem!.repliedMessgeCreatorId ==
                                        context.read<AppUserBloc>().appUser.id)
                                    ? 'You'
                                    : messageItem!.repliedTo ?? ''
                                : '',
                        showIcon: showIcon,
                      );
                    }),
                    AppSizedBox.sizedBox5H,
                    MessageContent(
                      isReplychat: isReplyChat,
                      messageType: messageType,
                      message: message,
                      assetLink: assetLink,
                    ),
                  ],
                ),
              ),
              if (isReplyChat &&
                  (messageType == MessageTypeConst.gifMessage ||
                      messageType == MessageTypeConst.photoMessage))
                Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: CachedNetworkImage(
                    imageUrl: messageType == MessageTypeConst.gifMessage
                        ? message!
                        : assetLink!,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final String userName;
  final bool showIcon;
  const HeaderRow({super.key, required this.userName, required this.showIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          userName,
          style: AppTextTheme.labelMediumRedVariant.labelMedium
              ?.copyWith(fontSize: 13.sp),
        ),
        if (showIcon)
          GestureDetector(
            onTap: () {
              context.read<MessageCubit>().initialState();
            },
            child: Icon(Icons.close, size: 16.w),
          ),
      ],
    );
  }
}

class MessageContent extends StatelessWidget {
  final String messageType;
  final String? message;
  final String? assetLink;
  final bool isReplychat;
  const MessageContent(
      {super.key,
      required this.messageType,
      required this.isReplychat,
      this.message,
      this.assetLink});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getMessageIcon(messageType),
            MessageCaption(
              messageType: messageType,
              message: message,
            ),
            if (!isReplychat)
              getMessageImage(
                messageType,
                message,
                assetLink,
              ),
          ],
        );
      },
    );
  }

  Widget getMessageIcon(String messageType) {
    switch (messageType) {
      case MessageTypeConst.videoMessage:
        return const Icon(Icons.video_collection_rounded);
      case MessageTypeConst.photoMessage:
        return const Icon(Icons.photo);
      case MessageTypeConst.gifMessage:
        return const Icon(Icons.gif);
      case MessageTypeConst.audioMessage:
        return const Icon(Icons.audiotrack_outlined);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getMessageImage(
    String messageType,
    String? message,
    String? assetLink,
  ) {
    if ((messageType == MessageTypeConst.photoMessage && assetLink != null) ||
        (messageType == MessageTypeConst.gifMessage && message != null)) {
      return CachedNetworkImage(
        imageUrl:
            messageType == MessageTypeConst.gifMessage ? message! : assetLink!,
        width: 30.w,
        height: 40.w,
        fit: BoxFit.cover,
      );
    }
    return const SizedBox.shrink();
  }
}

class MessageCaption extends StatelessWidget {
  final String messageType;
  final String? message;

  const MessageCaption({
    super.key,
    required this.messageType,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    if ((messageType == MessageTypeConst.textMessage ||
            messageType == MessageTypeConst.videoMessage ||
            messageType == MessageTypeConst.photoMessage) &&
        message != null) {
      return Expanded(
        child: Text(
          message!,
          style: AppTextTheme.bodyMeidumwhiteVariant.bodyMedium?.copyWith(
              fontSize: 13.sp, color: AppDarkColor().primaryTextBlur),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:social_media_app/core/const/app_config/app_padding.dart';
// import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
// import 'package:social_media_app/core/const/message_type.dart';
// import 'package:social_media_app/core/theme/color/app_colors.dart';
// import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
// import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
// import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
// import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_side_bar.dart';
// import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

// class ReplyPreviewWidget extends StatelessWidget {
//   const ReplyPreviewWidget(
//       {super.key, required this.message, required this.isME});
//   final MessageEntity message;
//   final bool isME;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: AppPadding.onlyTopMedium,
//       padding: AppPadding.small,
//       decoration: BoxDecoration(
//         color: !isME
//             ? AppDarkColor().secondaryBackground
//             : AppDarkColor().buttonBackground,
//         borderRadius: BorderRadius.only(
//             topLeft: ChatConstants.commonborderRadius12,
//             topRight: ChatConstants.commonborderRadius12),
//       ),
//       child: IntrinsicHeight(
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(
//                     color: isME
//                         ? AppDarkColor().buttonBackground
//                         : AppDarkColor().softBackground,
//                     width: 2)),
//             color: isME
//                 ? Color.fromARGB(255, 193, 86, 102)
//                 : AppDarkColor().secondaryBackground.withOpacity(.3),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ChatSideBar(
//                 isMe: isME,
//               ),
//               AppSizedBox.sizedBox5W,
              
//               Builder(builder: (context) {
//                 return Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           if (message.repliedTo != null)
//                             Text(
//                               message.repliedTo!,
//                               style: AppTextTheme
//                                   .bodyMeidumwhiteVariant.bodyMedium,
//                             ),
//                         ],
//                       ),
//                       AppSizedBox.sizedBox5H,

//                       Builder(builder: (context) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             message.messageType == MessageTypeConst.gifMessage
//                                 ? const Icon(Icons.gif)
//                                 : message.messageType ==
//                                         MessageTypeConst.audioMessage
//                                     ? const Icon(Icons.audiotrack_outlined)
//                                     : (message.messageType ==
//                                                     MessageTypeConst
//                                                         .textMessage ||
//                                                 message.messageType ==
//                                                     MessageTypeConst
//                                                         .videoMessage ||
//                                                 message.messageType ==
//                                                     MessageTypeConst
//                                                         .photoMessage) &&
//                                             message.message != null
//                                         ? Expanded(
//                                             child: Text(
//                                               message.repliedMessage ?? '',
//                                               maxLines: 2,
//                                               style: AppTextTheme
//                                                   .bodyMeidumwhiteVariant
//                                                   .bodyMedium,
//                                             ),
//                                           )
//                                         : EmptyDisplay(),
//                             (message.messageType ==
//                                             MessageTypeConst.photoMessage &&
//                                         message.assetPath != null) ||
//                                     (message.messageType ==
//                                             MessageTypeConst.gifMessage &&
//                                         message.message != null)
//                                 ? Image.network(
//                                     message.messageType ==
//                                             MessageTypeConst.gifMessage
//                                         ? message.message!
//                                         : message.assetLink!,
//                                     width: 30.w,
//                                   )
//                                 : EmptyDisplay()
//                           ],
//                         );
//                       })
//                       // : messageInfoStoreState.messageType ==
//                       //         MessageTypeConst.audioMessage
//                       //     ? Icon(Icons.audio_file)
//                       //     : EmptyDisplay()
//                     ],
//                   ),
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
