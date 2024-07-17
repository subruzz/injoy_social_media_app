import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/assets/domain/usecae/get_albums.dart';

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
      final res = await _loadAlbumsUseCase(NoParams());
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
    final List<File> selectedAsset = [];
    for (var image in event.selctedAssets) {
      File? file = await image.file;
      if (file == null) continue;
      selectedAsset.add(file);
    }
    emit(AssetToFileSuccess(selectedFileImages: selectedAsset));
  }
}
