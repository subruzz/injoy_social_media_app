part of 'assets_bloc.dart';

sealed class AssetsState extends Equatable {
  const AssetsState();
  
  @override
  List<Object> get props => [];
}

final class AssetsInitial extends AssetsState {}

final class AssetLoading extends AssetsState {}

final class AssetFailure extends AssetsState {
  final String error;

  final String errorDetails;

  const AssetFailure({required this.error, required this.errorDetails});
}

final class AssetSuccess extends AssetsState {
  final List<AssetEntity> assets;

  const AssetSuccess({required this.assets});
}