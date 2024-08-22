import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';

import '../../../../../../core/const/app_config/app_border_radius.dart';
import '../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../core/widgets/textfields/custom_textform_field.dart';
import '../../../cubits/cubit/ai_chat_cubit.dart';

class AiChatInput extends StatefulWidget {
  const AiChatInput({super.key, required this.l10n});
  final AppLocalizations l10n;
  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput> {
  final _aiChatController = TextEditingController();
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _aiChatController.dispose();
    super.dispose();
  }

  // void _toggleDrawer(BuildContext context) {
  //   FocusScope.of(context).unfocus(); // Dismisses the keyboard
  //   Scaffold.of(context).openDrawer(); // Opens the drawer
  // }

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
                // focusNode: _focusNode,
                radius: AppBorderRadius.large,
                hintText: widget.l10n.typeSomething,
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
