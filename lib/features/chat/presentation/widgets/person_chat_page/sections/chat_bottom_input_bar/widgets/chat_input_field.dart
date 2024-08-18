import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/extensions/stop_watch.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/reply_preview_widget.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

import '../../../../../../../../core/const/enums/media_picker_type.dart';
import '../../../../../../../../core/const/enums/message_type.dart';

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
    return BlocConsumer<MessageCubit, MessageState>(
      builder: (context, messageInfoStoreState) {
        return Column(
          children: [
            messageInfoStoreState is MessageReplyClicked
                ? ReplyPreviewWidget(
                    assetLink: messageInfoStoreState.assetPath,
                    showIcon: true,
                    message: messageInfoStoreState.caption,
                    messageType: messageInfoStoreState.messageType,
                    userName: messageInfoStoreState.repliedToMe
                        ? AppUiStringConst.you
                        : messageInfoStoreState.userName,
                  )
                : const EmptyDisplay(),
            SizedBox(
              height: isThatTabOrDeskTop ? 50 : null,
              child: TextField(
                focusNode: focusNode,
                onChanged: (value) {
                  // if (showAttachWindow.value) {
                  //   showAttachWindow.value = false;
                  // }
                  toggleButton.value = value.isEmpty;
                  log(toggleButton.value.toString());
                },
                controller: messageController,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
                decoration: InputDecoration(
                  hintStyle:
                      isThatTabOrDeskTop ? const TextStyle(fontSize: 13) : null,
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
                            messageState: context.read<GetMessageCubit>().state,
                            recentTextMessage: url,
                            messageType: MessageTypeConst.gifMessage);
                      }
                    },
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: AppDarkColor().iconSoftColor,
                    ),
                  ),
                  hintText: AppUiStringConst.message,
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
  }
}
