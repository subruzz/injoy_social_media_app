import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/stop_watch.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';

class ChatInputBarSection extends StatelessWidget {
  const ChatInputBarSection(
      {super.key,
      required this.messageController,
      required this.showAttachWindow,
      required this.sendMessage,
      required this.toggleButton});
  final TextEditingController messageController;
  final ValueNotifier<bool> showAttachWindow;
  final ValueNotifier<bool> toggleButton;
  final VoidCallback? sendMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
              child: BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppDarkColor().secondaryBackground,
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    if (showAttachWindow.value) {
                      showAttachWindow.value = false;
                    }
                    context.read<MessageAttributeBloc>().add(TextCliked());
                    toggleButton.value = value.isNotEmpty;
                  },
                  controller: messageController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          state is AudioOngoingState
                              ? Icons.mic
                              : Icons.emoji_emotions_outlined,
                          color: state is AudioOngoingState
                              ? Colors.red
                              : AppDarkColor().iconSoftColor,
                        ),
                      ),
                      filled: false,
                      hintStyle: TextStyle(
                          fontSize: state is AudioOngoingState ? 16 : 13),
                      hintText: state is AudioOngoingState
                          ? state.duration.formatDuration()
                          : 'Message',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 10),
                        child: Wrap(
                          children: [
                            GestureDetector(

                                // onTap: () {
                                //   _showAttachWindow.value =
                                //       !_showAttachWindow.value;
                                // },
                                child: const Icon(Icons.attach_file_outlined)),
                            AppSizedBox.sizedBox15W,
                            GestureDetector(
                                onTap: () {
                                  context.pushNamed(
                                    MyAppRouteConst.mediaPickerRoute,
                                    extra: {'pickerType': MediaPickerType.chat},
                                  );
                                },
                                child: const Icon(Icons.camera_alt_outlined))
                          ],
                        ),
                      ),
                      focusedBorder: InputBorder.none),
                ),
              );
            },
          )),
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
      ),
    );
  }
}
