import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/chat_main_tab_page/common_widgets/empty_chat_holder.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/chat_item.dart';

class ChatListingSectionSection extends StatelessWidget {
  const ChatListingSectionSection(
      {super.key, required this.goToBottom, required this.scrollController});
  final VoidCallback goToBottom;
  final ScrollController scrollController;
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
                  return ChatItem(
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
                      onSwipe: () {});
                });
          }
          return const Center(child: CircularLoadingGrey());
        },
      ),
    );
  }
}
