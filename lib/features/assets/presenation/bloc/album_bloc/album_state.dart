part of 'album_bloc.dart';

sealed class AlbumBlocState extends Equatable {
  const AlbumBlocState();

  @override
  List<Object> get props => [];
}

final class AlbumBlocInitial extends AlbumBlocState {}

final class AlbumNoPermission extends AlbumBlocState {}

final class AlbumLoading extends AlbumBlocState {}

final class AlbumSuccess extends AlbumBlocState {
  final List<AssetPathEntity> allAlbums;
  const AlbumSuccess({required this.allAlbums});
}

final class AlbumFailure extends AlbumBlocState {
  final String error;

  final String errorDetails;

  const AlbumFailure({required this.error, required this.errorDetails});
}

final class AssetToFileLoading extends AlbumBlocState {}

final class AssetToFileSuccess extends AlbumBlocState {
  final SelectedImagesDetails selectedImages;

  const AssetToFileSuccess({required this.selectedImages});
}

final class AssetToFileError extends AlbumBlocState {
  final String errorMessage;

  const AssetToFileError({required this.errorMessage});
}
