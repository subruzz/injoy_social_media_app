import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/chat/presentation/pages/custom_gallery.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/empty_chat_holder.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_item.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatListingSectionSection extends StatelessWidget {
  const ChatListingSectionSection(
      {super.key,
      required this.goToBottom,
      required this.scrollController,
      required this.onSwipe});
  final VoidCallback goToBottom;
  final ScrollController scrollController;
  final Function(MessageEntity) onSwipe;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    return Expanded(
      child: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          if (state is MessageFailure) {
            return const Center(
              child: AppErrorGif(),
            );
          }
          if (state is MessageLoaded) {
            if (state.messages.isEmpty) {
              return const EmptyChatHolder(
                message: 'No Chat history found,\nStart messaging!',
              );
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              goToBottom();
            });
            return ListView.builder(
                controller: scrollController,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  if (!message.isSeen &&
                      message.senderUid !=
                          context.read<AppUserBloc>().appUser.id) {
                    log('seen caleed');
                    context
                        .read<MessageCubit>()
                        .seeMessage(messageId: message.messageId);
                  }
                  return SwipeTo(
                    onRightSwipe: (details) {
                      context.read<MessageInfoStoreCubit>().replyClicked(
                          isMe: message.senderUid ==
                              context.read<AppUserBloc>().appUser.id,
                          messageType: message.messageType,
                          assetPath: message.assetLink,
                          caption: message.message);
                    },
                    child: ChatItem(
                        onTap: message.messageType ==
                                    MessageTypeConst.photoMessage ||
                                message.messageType ==
                                    MessageTypeConst.photoMessage
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MediaGalleryView(
                                      messages: state.messages,
                                      initialIndex: index),
                                ));
                              }
                            : null,
                        messageItem: message,
                        messageType: message.messageType,
                        createAt:
                            message.createdAt!.toDate().timeAgoChatExtension(),
                        message: message.message,
                        isSeen: false,
                        isShowTick: message.senderUid == user.id ? true : false,
                        isMe: message.senderUid ==
                            context.read<AppUserBloc>().appUser.id,
                        onLongPress: () {
                          if (message.senderUid ==
                              context.read<AppUserBloc>().appUser.id) {
                            HapticFeedback.heavyImpact();
                            AppInfoDialog.showInfoDialog(
                                context: context,
                                subtitle:
                                    'Are you you want to delete this message?',
                                callBack: () {
                                  context.read<MessageCubit>().deleteMessage(
                                      messageId: message.messageId);
                                },
                                buttonText: 'Delete');
                          }
                        },
                        onSwipe: () {}),
                  );
                });
          }
          return const Center(child: CircularLoadingGrey());
        },
      ),
    );
  }
}
