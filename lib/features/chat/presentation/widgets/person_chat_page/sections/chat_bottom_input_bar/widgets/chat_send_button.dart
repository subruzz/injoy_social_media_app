import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';

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
    return BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
      builder: (context, state) {
        return Positioned(
          bottom: state is AudioOngoingState ? -10.h : 8.h,
          right: state is AudioOngoingState ? -5.h : 5.w,
          child: GestureDetector(
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
            child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(microseconds: 0),
              width: state is AudioOngoingState ? 100.w : 50.w,
              height: state is AudioOngoingState ? 100.w : 50.w,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(state is AudioOngoingState ? 50 : 25),
                color: AppDarkColor().buttonBackground,
              ),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: toggleButton,
                  builder: (context, value, child) {
                    return Icon(value ? Icons.send_outlined : Icons.mic,
                        size: state is AudioOngoingState ? 40.w : 20.w);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
