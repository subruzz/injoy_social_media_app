part of 'album_bloc.dart';

sealed class AlbumBlocEvent extends Equatable {
  const AlbumBlocEvent();

  @override
  List<Object> get props => [];
}

final class GetAlbumsEvent extends AlbumBlocEvent {}

final class AssetToFileEvent extends AlbumBlocEvent {
  final List<AssetEntity> selctedAssets;

 const  AssetToFileEvent({required this.selctedAssets});
}
