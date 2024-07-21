import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/extensions/stop_watch.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class ChatInputBarSection extends StatelessWidget {
  const ChatInputBarSection({
    super.key,
    required this.messageController,
    required this.showAttachWindow,
    required this.sendMessage,
    required this.toggleButton,
  });

  final TextEditingController messageController;
  final ValueNotifier<bool> showAttachWindow;
  final ValueNotifier<bool> toggleButton;
  final VoidCallback? sendMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
            builder: (context, messageAttributeState) {
              return BlocBuilder<MessageInfoStoreCubit, MessageInfoStoreState>(
                builder: (context, messageInfoStoreState) {
                  return Column(
                    children: [
                      if (messageInfoStoreState is MessageReplyClicked)
                        MessageDisplay(
                            messageInfoStoreState: messageInfoStoreState),
                      TextField(
                        onChanged: (value) {
                          if (showAttachWindow.value) {
                            showAttachWindow.value = false;
                          }
                          context
                              .read<MessageAttributeBloc>()
                              .add(TextCliked());
                          toggleButton.value = value.isNotEmpty;
                        },
                        controller: messageController,
                        decoration: InputDecoration(
                          fillColor: AppDarkColor().softBackground,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: messageInfoStoreState
                                    is MessageReplyClicked
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))
                                : const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          prefixIcon: GestureDetector(
                            onTap: () async {
                              final GiphyGif? gif = await pickGif(context);
                              if (gif != null && context.mounted) {
                                final url =
                                    'https://media.giphy.com/media/${gif.id}/giphy.gif';
                                context.read<MessageCubit>().sendMessage(
                                    recentTextMessage: url,
                                    messageType: MessageTypeConst.gifMessage);
                              }
                            },
                            child: Icon(
                              messageAttributeState is AudioOngoingState
                                  ? Icons.mic
                                  : Icons.emoji_emotions_outlined,
                              color: messageAttributeState is AudioOngoingState
                                  ? Colors.red
                                  : AppDarkColor().iconSoftColor,
                            ),
                          ),
                          hintText: messageAttributeState is AudioOngoingState
                              ? messageAttributeState.duration.formatDuration()
                              : 'Message',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                MyAppRouteConst.mediaPickerRoute,
                                extra: {'pickerType': MediaPickerType.chat},
                              );
                            },
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        AppSizedBox.sizedBox5W,
        GestureDetector(
          onLongPressEnd: (details) {
            toggleButton.value
                ? null
                : context
                    .read<MessageAttributeBloc>()
                    .add(AudioMessageStopped());
          },
          onLongPress: () {
            if (!toggleButton.value) {
              HapticFeedback.vibrate();
              context.read<MessageAttributeBloc>().add(AudioMessageClicked());
            }
          },
          onTap: () {
            if (context.read<MessageCubit>().state is! MessageLoaded) {
              return;
            }
            toggleButton.value ? sendMessage?.call() : null;
            toggleButton.value = false;

            messageController.clear();
          },
          child: BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
            builder: (context, state) {
              return AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(microseconds: 0),
                width: state is AudioOngoingState ? 80 : 50,
                height: state is AudioOngoingState ? 80 : 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      state is AudioOngoingState ? 50 : 25),
                  color: AppDarkColor().buttonBackground,
                ),
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: toggleButton,
                    builder: (context, value, child) {
                      return Icon(value ? Icons.send_outlined : Icons.mic);
                    },
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class MessageDisplay extends StatelessWidget {
  final MessageReplyClicked messageInfoStoreState;

  const MessageDisplay({Key? key, required this.messageInfoStoreState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      decoration: BoxDecoration(
        color: AppDarkColor().softBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              thickness: 4,
              width: 4,
              color: AppDarkColor().buttonBackground,
            ),
            AppSizedBox.sizedBox5W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderRow(messageInfoStoreState: messageInfoStoreState),
                  AppSizedBox.sizedBox5H,
                  MessageContent(messageInfoStoreState: messageInfoStoreState),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  final MessageReplyClicked messageInfoStoreState;

  const HeaderRow({Key? key, required this.messageInfoStoreState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          messageInfoStoreState.isMe ? 'You' : messageInfoStoreState.userName,
        ),
        GestureDetector(
          onTap: () {
            context.read<MessageInfoStoreCubit>().replyRemoved();
          },
          child: const Icon(Icons.close, size: 16),
        ),
      ],
    );
  }
}

class MessageContent extends StatelessWidget {
  final MessageReplyClicked messageInfoStoreState;

  const MessageContent({Key? key, required this.messageInfoStoreState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getMessageIcon(messageInfoStoreState),
            getMessageCaption(messageInfoStoreState),
            getMessageImage(messageInfoStoreState),
          ],
        );
      },
    );
  }

  Widget getMessageIcon(MessageReplyClicked state) {
    switch (state.messageType) {
      case MessageTypeConst.gifMessage:
        return const Icon(Icons.gif);
      case MessageTypeConst.audioMessage:
        return const Icon(Icons.audiotrack_outlined);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget getMessageCaption(MessageReplyClicked state) {
    if ((state.messageType == MessageTypeConst.textMessage ||
            state.messageType == MessageTypeConst.videoMessage ||
            state.messageType == MessageTypeConst.photoMessage) &&
        state.caption != null) {
      return Expanded(
        child: Text(
          state.caption ?? '',
          maxLines: 2,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget getMessageImage(MessageReplyClicked state) {
    if ((state.messageType == MessageTypeConst.photoMessage &&
            state.assetPath != null) ||
        (state.messageType == MessageTypeConst.gifMessage &&
            state.caption != null)) {
      return Image.network(
        state.messageType == MessageTypeConst.gifMessage
            ? state.caption!
            : state.assetPath!,
        width: 30.w,
      );
    }
    return const SizedBox.shrink();
  }
}
