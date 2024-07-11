import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_msg/app_success_msg.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/textfields/content_input_textfield.dart';
import 'package:social_media_app/core/widgets/custom_round_button.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';

class MultipleStatusInputBar extends StatelessWidget {
  const MultipleStatusInputBar(
      {super.key,
      required this.captionController,
      required this.alreadySelected,
      required this.captions,
      this.onCaptionChanged,
      required this.leadingIconPressed});
  final TextEditingController captionController;
  final List<AssetEntity> alreadySelected;
  final List<String> captions;
  final void Function(String)? onCaptionChanged;
  final VoidCallback leadingIconPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ColoredBox(
        color: AppDarkColor().background,
        child: Row(
          children: [
            Expanded(
              child: ContentInputTextfield(
                  controller: captionController,
                  hintText: 'Add a caption...',
                  onChanged: onCaptionChanged,
                  prefixIcon: const Icon(Icons.photo_library),
                  leadingPressed:  leadingIconPressed),
            ),
            const SizedBox(width: 10),
            BlocConsumer<StatusBloc, StatusState>(
              listenWhen: (previousState, state) {
                return state is StatusCreateLoading ||
                    state is StatusCreateFailure ||
                    state is StatusCreateSuccess;
              },
              listener: (context, state) {
                if (state is StatusCreateFailure) {
                  Messenger.showSnackBar(
                      message: AppErrorMessages.statusCreationFailed);
                }
                if (state is StatusCreateSuccess) {
                  Messenger.showSnackBar(
                      message: AppSuccessMsg.statusCreatedSuccess);
                  Navigator.pop(context);
                }
              },
              // buildWhen: (previous, current) {
              //  return  current is StatusCreateLoading;
              // },
              builder: (context, state) {
                if (state is StatusCreateLoading) {
                  return Padding(
                    padding: AppPadding.onlyRightMedium,
                    child: const CircularLoading(),
                  );
                }
                return CustomRoundButton(
                    icon: Icons.send,
                    onPressed: () {
                      final user = context.read<AppUserBloc>().appUser;
                      context.read<StatusBloc>().add(CreateMultipleStatusEvent(
                          userId: user.id,
                          userName: user.userName ?? '',
                          captions: captions,
                          statusImages: alreadySelected));
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
