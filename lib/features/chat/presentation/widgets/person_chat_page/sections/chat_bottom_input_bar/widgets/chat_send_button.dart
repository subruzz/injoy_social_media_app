import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/services/app_interal/haptic_feedback.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';

class ChatSendButton extends StatelessWidget {
  const ChatSendButton({
    super.key,
    required this.toggleButton,
    required this.sendMessage,
    required this.messageController,
  });

  final ValueNotifier<bool> toggleButton;
  final VoidCallback? sendMessage;
  final TextEditingController messageController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        log(state.toString());
        return Positioned(
            bottom: state is VoiceMessageOngoing
                ? isThatTabOrDeskTop
                    ? -10
                    : -10.h
                : isThatTabOrDeskTop
                    ? 8
                    : 8.h,
            right: state is VoiceMessageOngoing
                ? isThatTabOrDeskTop
                    ? -10
                    : -10.w
                : isThatTabOrDeskTop
                    ? 5
                    : 5.w,
            child: GestureDetector(
              onLongPressEnd: (details) {
                if (kIsWeb) return;
                if (!toggleButton.value) return;
                final state = context.read<GetMessageCubit>().state;
                context.read<MessageCubit>().voiceRecordStopped(state);
              },
              onLongPress: () {
                if (kIsWeb) return;

                if (!toggleButton.value) return;
                HapticFeedbackHelper().vibrate();
                context.read<MessageCubit>().voiceRecordingStarted();
              },
              onTap: () {
                // if ( context.read<MessageCubit>().state is! MessageLoaded) {
                //   return;
                // }
                !toggleButton.value ? sendMessage?.call() : null;
                toggleButton.value = true;

                messageController.clear();
              },
              child: AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(microseconds: 0),
                width: state is VoiceMessageOngoing
                    ? 100
                    : isThatTabOrDeskTop
                        ? 50
                        : 50.w,
                height: state is VoiceMessageOngoing
                    ? 100
                    : isThatTabOrDeskTop
                        ? 50
                        : 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      state is VoiceMessageOngoing ? 50 : 25),
                  color: AppDarkColor().buttonBackground,
                ),
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: toggleButton,
                    builder: (context, value, child) {
                      return Icon(
                          value && !kIsWeb ? Icons.mic : Icons.send_outlined);
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
