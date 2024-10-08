import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/enums/media_picker_type.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/media_picker/presenation/widgets/grid_asset_showing_section/widgets/each_assets.dart';

class GridAssetSection extends StatelessWidget {
  const GridAssetSection(
      {super.key,
      required this.isSelectedEmpty,
      required this.mainAsset,
      required this.mediaPickerType,
      required this.selectedAssetList});
  final ValueNotifier<AssetEntity?> mainAsset;
  final ValueNotifier<bool> isSelectedEmpty;
  final MediaPickerType mediaPickerType;
  final List<AssetEntity> selectedAssetList;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssetsBloc, AssetsState>(
      buildWhen: (previous, current) =>
          previous is! AssetSuccess && current is AssetSuccess ||
          current is AssetLoading ||
          current is AssetFailure,
      builder: (context, state) {
        if (state is AssetLoading) {
          return const Expanded(
            child: Center(
              child: CircularLoading(),
            ),
          );
        }
        if (state is AssetFailure) {
          return Text(state.error);
        }
        if (state is AssetSuccess) {
          log('success');
          return Expanded(
            child: GridView.builder(
              padding: AppPadding.horizontalSmall,
              itemCount: state.assets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemBuilder: (context, index) {
                return AssetItems(
                    mediaPickerType: mediaPickerType,
                    mainAsset: mainAsset,
                    addToSelected: () {
                      isSelectedEmpty.value = selectedAssetList.isNotEmpty;
                    },
                    assetEntity: state.assets[index],
                    selected: selectedAssetList);
              },
            ),
          );
        }
        return const EmptyDisplay();
      },
      listener: (context, state) {
        if (state is AssetSuccess) {
          mainAsset.value = state.assets.first;
        }
      },
    );
  }
}
