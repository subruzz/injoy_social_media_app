import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/features/assets/domain/usecase/get_albums.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumBlocEvent, AlbumBlocState> {
  final LoadAlbumsUseCase _loadAlbumsUseCase;
  AlbumBloc(this._loadAlbumsUseCase) : super(AlbumBlocInitial()) {
    on<AlbumBlocEvent>((event, emit) {
      emit(AlbumLoading());
    });
    on<GetAlbumsEvent>((event, emit) async {
      final res =
          await _loadAlbumsUseCase(LoadAlbumsUseCaseParams(type: event.type));
      res.fold(
          (failure) => emit(AlbumFailure(
              error: failure.message,
              errorDetails: failure.details)), (success) {
        if (!success.$2) {
          return emit(AlbumNoPermission());
        }
        emit(
          AlbumSuccess(allAlbums: success.$1),
        );
      });
    });
  }
}
