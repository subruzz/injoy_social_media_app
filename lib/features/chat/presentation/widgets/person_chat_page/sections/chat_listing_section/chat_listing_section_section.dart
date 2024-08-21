import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/common_empty_holder.dart';
import 'package:social_media_app/core/widgets/dialog/app_info_dialog.dart';
import 'package:social_media_app/core/const/app_msg/app_info_msg.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/const/extensions/datetime_to_string.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/pages/custom_gallery.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_item.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../cubits/messages_cubits/message/message_cubit.dart';

class ChatListingSectionSection extends StatelessWidget {
  const ChatListingSectionSection({
    super.key,
    required this.goToBottom,
    required this.scrollController,
    required this.onSwipe,
    required this.myid,
    this.onmessageDateChange,
    required this.getMessageCubit,
  });

  final VoidCallback goToBottom;
  final ScrollController scrollController;
  final Function(MessageEntity) onSwipe;
  final String myid;
  final Function(String)? onmessageDateChange;
  final GetMessageCubit getMessageCubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<GetMessageCubit, GetMessageState>(
        bloc: getMessageCubit,
        listener: (context, state) {
          if (state.messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              goToBottom();
            });
          }
        },
        builder: (context, state) {
          if (state.errorMessage != null) {
            return const Center(child: AppErrorGif());
          }
          if (state.loading) {
            return const Center(child: CircularLoadingGrey());
          }
          if (state.messages.isEmpty) {
            return const CommonEmptyHolder(
              asset: AppAssetsConst.noChatHolder,
              message: AppUiStringConst.noPersonalChatFound,
            );
          }

          final groupedMessages = _groupMessagesByDate(state.messages);

          return ListView.builder(
            controller: scrollController,
            itemCount: groupedMessages.length,
            itemBuilder: (context, index) {
              final date = groupedMessages.keys.elementAt(index);
              final messages = groupedMessages[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the date header
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        date,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: isThatTabOrDeskTop ? 14 : null),
                      ),
                    ),
                  ),
                  ...messages.map((message) {
                    return SwipeTo(
                      onRightSwipe: (details) {
                        final state = getMessageCubit.state;
                        context.read<MessageCubit>().replyClicked(
                              otherUserState: state,
                              repliedMessagecreator: message.senderUid,
                              isMe: message.senderUid == myid,
                              messageType: message.messageType,
                              assetPath: message.assetLink,
                              caption: message.message,
                            );
                      },
                      child: ChatItem(
                        onTap: message.messageType ==
                                    MessageTypeConst.photoMessage ||
                                message.messageType ==
                                    MessageTypeConst.photoMessage
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MediaGalleryView(
                                      messages: state.messages,
                                      initialIndex: index,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        messageItem: message,
                        isShowTick: message.senderUid == myid,
                        isMe: message.senderUid == myid,
                        onLongPress: () {
                          if (message.senderUid == myid) {
                            HapticFeedback.heavyImpact();
                            AppInfoDialog.showInfoDialog(
                              context: context,
                              subtitle: AppIngoMsg.deleteMessage,
                              callBack: () {
                                context.read<MessageCubit>().deleteMessage(
                                    messageState: getMessageCubit.state,
                                    messageId: message.messageId);
                              },
                              buttonText: AppUiStringConst.delete,
                            );
                          }
                        },
                      ),
                    );
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Map<String, List<MessageEntity>> _groupMessagesByDate(
      List<MessageEntity> messages) {
    final groupedMessages = <String, List<MessageEntity>>{};

    for (var message in messages) {
      final createdAt = message.createdAt!.toDate();
      final date = createdAt.formatDate();

      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }
      groupedMessages[date]!.add(message);
    }

    return groupedMessages;
  }
}
