part of 'asset_bloc_bloc.dart';

sealed class AssetBlocState extends Equatable {
  const AssetBlocState();

  @override
  List<Object> get props => [];
}

final class AssetBlocInitial extends AssetBlocState {}

final class AssetLoading extends AssetBlocState {}

final class AssetFailure extends AssetBlocState {
  final String error;

  final String errorDetails;

  const AssetFailure({required this.error, required this.errorDetails});
}

final class AssetSuccess extends AssetBlocState {
  final List<AssetEntity> assets;

  const AssetSuccess({required this.assets});
}

final class AssetNoPermission extends AssetBlocState {}
