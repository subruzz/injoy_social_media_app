part of 'album_bloc.dart';

sealed class AlbumBlocEvent extends Equatable {
  const AlbumBlocEvent();

  @override
  List<Object> get props => [];
}

final class GetAlbumsEvent extends AlbumBlocEvent {
  final RequestType type;

  const GetAlbumsEvent({this.type = RequestType.image});
}

// final class AssetToFileEvent extends AlbumBlocEvent {
//   final List<AssetEntity> selctedAssets;
//   final bool isPicKDiffAssets;

//   const AssetToFileEvent({
//     required this.selctedAssets,
//     this.isPicKDiffAssets = false,
//   });
// }
