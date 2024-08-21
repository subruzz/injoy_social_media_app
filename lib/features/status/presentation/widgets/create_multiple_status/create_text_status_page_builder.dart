
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/pages/create_text_status.dart';

class CreateTextStatusPageBuilder extends StatelessWidget {
  const CreateTextStatusPageBuilder(
      {super.key,
      required this.changeStatusScreen,
      required this.selectedAssets,
      required this.captonController});
  final VoidCallback changeStatusScreen;
  final List<SelectedByte> selectedAssets;
  final TextEditingController captonController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectColorCubit(),
      child: CreateTextStatusPage(
          changeStatusScreen: changeStatusScreen,
          selectedAssets: selectedAssets,
          captonController: captonController),
    );
  }
}
