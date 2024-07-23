import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/extensions/stop_watch.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/reply_preview_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

import '../../../../../../../../core/const/message_type.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.messageController,
    required this.showAttachWindow,
    required this.toggleButton,
    required this.focusNode,
  });

  final TextEditingController messageController;
  final ValueNotifier<bool> showAttachWindow;
  final ValueNotifier<bool> toggleButton;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
      builder: (context, messageAttributeState) {
        return BlocConsumer<MessageInfoStoreCubit, MessageInfoStoreState>(
          builder: (context, messageInfoStoreState) {
            return Column(
              children: [
                if (messageInfoStoreState is MessageReplyClicked)
                  ReplyPreviewWidget(
                    assetLink: messageInfoStoreState.assetPath,
                    showIcon: true,
                    message: messageInfoStoreState.caption,
                    messageType: messageInfoStoreState.messageType,
                    userName: messageInfoStoreState.isMe
                        ? AppUiStringConst.you
                        : messageInfoStoreState.userName,
                  ),
                TextField(
                  focusNode: focusNode,
                  onChanged: (value) {
                    if (showAttachWindow.value) {
                      showAttachWindow.value = false;
                    }
                    context.read<MessageAttributeBloc>().add(TextCliked());
                    toggleButton.value = value.isNotEmpty;
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                    fillColor: AppDarkColor().softBackground,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: messageInfoStoreState is MessageReplyClicked
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
                        : AppUiStringConst.message,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyAppRouteConst.mediaPickerRoute,
                          arguments: {'pickerType': MediaPickerType.chat},
                        );
                      },
                      child: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is MessageReplyClicked) {
              focusNode.requestFocus();
            }
          },
        );
      },
    );
  }
}
