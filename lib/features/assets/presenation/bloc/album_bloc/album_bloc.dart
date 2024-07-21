import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/asset_to_type.dart';
import 'package:social_media_app/features/assets/domain/usecae/get_albums.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumBlocEvent, AlbumBlocState> {
  final LoadAlbumsUseCase _loadAlbumsUseCase;
  AlbumBloc(this._loadAlbumsUseCase) : super(AlbumBlocInitial()) {
    on<AlbumBlocEvent>((event, emit) {
      emit(AlbumLoading());
    });
    on<AssetToFileEvent>(_converAssetToFile);
    on<GetAlbumsEvent>((event, emit) async {
      final res =
          await _loadAlbumsUseCase(LoadAlbumsUseCaseParams(type: event.type));
      res.fold(
        (failure) => emit(AlbumFailure(
            error: failure.message, errorDetails: failure.details)),
        (success) => emit(
          AlbumSuccess(allAlbums: success),
        ),
      );
    });
  }

  FutureOr<void> _converAssetToFile(
      AssetToFileEvent event, Emitter<AlbumBlocState> emit) async {
    emit(AssetToFileLoading());

    final List<SelectedByte> selectedAssetData = [];

    try {
      for (var asset in event.selctedAssets) {
        final fileData = await convertAssetToSelectedByte(asset);
        selectedAssetData.add(fileData);
      }
    } catch (e) {
      emit(AssetToFileError(errorMessage: e.toString()));
    }
    return emit(AssetToFileSuccess(
      selectedImages: SelectedImagesDetails(
          multiSelectionMode: event.isPicKDiffAssets,
          selectedFiles: selectedAssetData),
    ));
  }
}

// class AssetData {
//   final Uint8List data;
//   final AssetType type;

//   AssetData({required this.data, required this.type});
// }

// enum AssetType { image, video }
