import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/text_status_background_section/create_text_status_background.dart';
import 'package:social_media_app/features/status/presentation/widgets/common/status_app_bar.dart';

import '../../../../core/const/enums/media_picker_type.dart';

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
            floatingActionButton: !kIsWeb
                ? CustomAppPadding(
                    padding: AppPadding.floatingActionBottomPaddng,
                    child: AppCustomFloatingButton(
                        onPressed: () async {
                          final List<SelectedByte>? res =
                              await Navigator.pushNamed(
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
                  )
                : null,
            appBar: StatusAppBar(
              colorCubit: colorCubit,
              statusController: captonController,
            ),
            body: CreateTextStatusBackground(
                colorCubit: colorCubit, captionController: captonController));
      },
    );
  }
}
