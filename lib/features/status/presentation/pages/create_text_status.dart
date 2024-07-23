import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_msg/app_success_msg.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/app_related/rotated_icon.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/create_text_status_background.dart';
import 'package:social_media_app/features/status/presentation/widgets/status_app_bar.dart';

class CreateTextStatusPage extends StatelessWidget {
  const CreateTextStatusPage(
      {super.key,
      required this.changeStatusScreen,
      required this.selectedAssets,
      required this.captonController});
  final VoidCallback changeStatusScreen;
  final List<SelectedByte> selectedAssets;
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
                    final List<SelectedByte>? res = await Navigator.pushNamed(
                      context,
                      MyAppRouteConst.mediaPickerRoute,
                      arguments: {'pickerType': MediaPickerType.status},
                    ) as List<SelectedByte>?;

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
            appBar: StatusAppBar(
              color: colorCubit.color,
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
                        final currentUser = context.read<AppUserBloc>().appUser;
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
                      ),
                    );
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
