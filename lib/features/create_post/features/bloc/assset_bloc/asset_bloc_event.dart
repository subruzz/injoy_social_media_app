part of 'asset_bloc_bloc.dart';

sealed class AssetBlocEvent extends Equatable {
  const AssetBlocEvent();

  @override
  List<Object> get props => [];
}

final class GetAssetsEvent extends AssetBlocEvent {}
