import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/textfields/content_input_textfield.dart';
import 'package:social_media_app/core/widgets/common/custom_round_button.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';

import '../../../../../core/const/enums/message_type.dart';
import '../../../../../core/utils/extensions/localization.dart';
import '../../../../chat/presentation/cubits/messages_cubits/message/message_cubit.dart';

class MultipleStatusInputBar extends StatelessWidget {
  const MultipleStatusInputBar(
      {super.key,
      required this.captionController,
      required this.alreadySelected,
      required this.captions,
      this.onCaptionChanged,
      required this.isChat,
      this.getMessageCubit,
      required this.l10n,
      this.messageCubit});
  final TextEditingController captionController;
  final List<SelectedByte> alreadySelected;
  final List<String> captions;
  final void Function(String)? onCaptionChanged;
  final bool isChat;
  final GetMessageState? getMessageCubit;
  final MessageCubit? messageCubit;
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 0,
      bottom: 0,
      child: ColoredBox(
        color: AppDarkColor().background,
        child: Row(
          children: [
            Expanded(
              child: ContentInputTextfield(
                controller: captionController,
                hintText: l10n.addCaption,
                onChanged: onCaptionChanged,
              ),
            ),
            AppSizedBox.sizedBox10W,
            CustomRoundButton(
              icon: Icons.send,
              onPressed: () {
                final user = context.read<AppUserBloc>().appUser;
                if (isChat && messageCubit != null) {
                  messageCubit!.sendMessage(
                      messageState: getMessageCubit!,
                      recentTextMessage: '',
                      selectedAssets: alreadySelected,
                      messageType: MessageTypeConst.photoMessage,
                      captions: captions);
                } else {
                  context.read<StatusBloc>().add(CreateMultipleStatusEvent(
                      userId: user.id,
                      userName: user.userName ?? '',
                      captions: captions,
                      statusImages: alreadySelected));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
