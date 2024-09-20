import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/sections/chat_listing_section/widgets/reply_preview_widget.dart';
import 'package:social_media_app/features/media_picker/presenation/pages/custom_media_picker_page.dart';

import '../../../../../../../../core/const/chat_const/chat_const.dart';
import '../../../../../../../../core/const/enums/media_picker_type.dart';
import '../../../../../../../../core/const/enums/message_type.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.messageController,
    required this.showAttachWindow,
    required this.toggleButton,
    required this.focusNode,
    required this.getMessageCubit,
  });
  final GetMessageCubit getMessageCubit;
  final TextEditingController messageController;
  final ValueNotifier<bool> showAttachWindow;
  final ValueNotifier<bool> toggleButton;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<MessageCubit>().messageReplyNotifier,
      builder: (context, messageInfoStoreState, child) {
        return Column(
          children: [
            messageInfoStoreState != null
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
                height: 50,
                child: CustomTextField(
                  focusNode: focusNode,
                  controller: messageController,
                  hintText: 'Message',
                  radius: messageInfoStoreState is MessageReplyClicked
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))
                      : const BorderRadius.all(Radius.circular(20)),
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      final GiphyGif? gif = await pickGif(context);
                      if (gif != null && context.mounted) {
                        final url =
                            'https://media.giphy.com/media/${gif.id}/giphy.gif';
                        context.read<MessageCubit>().sendMessage(
                            messageState: getMessageCubit.state,
                            recentTextMessage: url,
                            messageType: MessageTypeConst.gifMessage);
                      }
                    },
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                      color: AppDarkColor().iconSecondarycolor,
                    ),
                  ),
                  onChanged: (value) {
                    toggleButton.value = value.isEmpty;
                  },
                  suffixIcon: AppAssetsConst.camera,
                  iconSize: 10,
                  suffixPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomMediaPickerPage(
                            pickerType: MediaPickerType.chat,
                            getMessageCubit: getMessageCubit.state,
                          ),
                        ));
                  },
                )),
          ],
        );
      },
      // listener: (context, state) {
      //   if (state is MessageReplyClicked) {
      //     focusNode.requestFocus();
      //   }
      // },
    );
  }
}
