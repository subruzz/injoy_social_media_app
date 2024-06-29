part of 'assets_bloc.dart';

sealed class AssetsEvent extends Equatable {
  const AssetsEvent();

  @override
  List<Object> get props => [];
}
final class GetAssetsEvent extends AssetsEvent {
  final AssetPathEntity selectedAlbum;

  const GetAssetsEvent({required this.selectedAlbum});
}