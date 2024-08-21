import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/asset_to_type.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

part 'asset_file_state.dart';

class AssetFileCubit extends Cubit<AssetFileState> {
  AssetFileCubit() : super(AssetFileInitial());
  void assetToFile({required final List<AssetEntity> selctedAssets}) async {
    emit(AssetFileLoading());

    final List<SelectedByte> selectedAssetData = [];
    try {
      for (var asset in selctedAssets) {
        final fileData = await convertAssetToSelectedByte(asset);
        selectedAssetData.add(fileData);
      }
    } catch (e) {
      emit(AssetFileError());
    }
    emit(AssetFileSuccess(
      selectedImages: SelectedImagesDetails(
          multiSelectionMode: false, selectedFiles: selectedAssetData),
    ));
  }
}
