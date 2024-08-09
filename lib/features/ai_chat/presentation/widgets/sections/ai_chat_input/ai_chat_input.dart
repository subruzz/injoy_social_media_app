import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/const/app_config/app_border_radius.dart';
import '../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../core/widgets/textfields/custom_textform_field.dart';
import '../../../cubits/cubit/ai_chat_cubit.dart';

class AiChatInput extends StatefulWidget {
  const AiChatInput({super.key});

  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput> {
  final _aiChatController = TextEditingController();

  @override
  void dispose() {
    _aiChatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                radius: AppBorderRadius.large,
                hintText: 'Type something...',
                controller: _aiChatController,
              ),
            ),
            AppSizedBox.sizedBox10W,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  final aiCubit = context.read<AiChatCubit>();
                  if (_aiChatController.text.trim().isEmpty ||
                      aiCubit.state.isLoading) {
                    return;
                  }
                  context
                      .read<AiChatCubit>()
                      .chatGenerateNewTextMessage(_aiChatController.text);
                  _aiChatController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
