import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_msg/app_success_msg.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/media_picker/custom_media_picker_page.dart';
import 'package:social_media_app/core/widgets/app_related/rotated_icon.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/create_text_status_background.dart';

class CreateTextStatusPage extends StatelessWidget {
  const CreateTextStatusPage(
      {super.key,
      required this.changeStatusScreen,
      required this.selectedAssets,
      required this.captonController});
  final VoidCallback changeStatusScreen;
  final List<AssetEntity> selectedAssets;
  final TextEditingController captonController;
  @override
  Widget build(BuildContext context) {
    final colorCubit = context.read<SelectColorCubit>();
    return BlocBuilder<SelectColorCubit, SelectColorState>(
      bloc: colorCubit,
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: CustomAppPadding(
              padding: AppPadding.floatingActionBottomPaddng,
              child: AppCustomFloatingButton(
                  onPressed: () async {
                    final List<AssetEntity>? res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomMediaPickerPage(
                          alreadySelected: selectedAssets,
                        ),
                      ),
                    );
                    selectedAssets.clear();

                    if (res != null) {
                      changeStatusScreen();
                      selectedAssets.addAll(res);
                    } else {
                      selectedAssets.clear();
                    }
                  },
                  child: const Icon(Icons.camera_sharp)),
            ),
            appBar: AppCustomAppbar(
              backGroundColor: colorCubit.color,
              showLeading: true,
              title: Text(
                'Create Status',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              actions: [
                BlocConsumer<StatusBloc, StatusState>(
                  listener: (context, state) {
                    if (state is StatusCreateSuccess) {
                      Navigator.pop(context);
                      Messenger.showSnackBar(
                          message: AppSuccessMsg.statusCreatedSuccess);
                    }
                    if (state is StatusCreateFailure) {
                      Messenger.showSnackBar(message: state.errorMsg);
                    }
                  },
                  builder: (context, state) {
                    if (state is StatusCreateLoading) {
                      return Padding(
                        padding: AppPadding.onlyRightMedium,
                        child: const CircularLoading(),
                      );
                    }
                    return IconButton(
                        onPressed: () {
                          final currentUser =
                              context.read<AppUserBloc>().appUser!;
                          context.read<StatusBloc>().add(CreateStatusEvent(
                              userId: currentUser.id,
                              profilePic: currentUser.profilePic,
                              userName: currentUser.userName ?? '',
                              content: captonController.text.trim(),
                              color: colorCubit.color.value,
                              statusImage: null));
                        },
                        icon: const RotatedIcon(
                          icon: Icons.send_outlined,
                        ));
                  },
                )
              ],
            ),
            body: CreateTextStatusBackground(
                colorCubit: colorCubit, captionController: captonController));
      },
    );
  }
}
