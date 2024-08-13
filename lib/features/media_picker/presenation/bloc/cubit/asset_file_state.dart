part of 'asset_file_cubit.dart';

sealed class AssetFileState extends Equatable {
  const AssetFileState();

  @override
  List<Object> get props => [];
}

final class AssetFileInitial extends AssetFileState {}

final class AssetFileLoading extends AssetFileState {}

final class AssetFileSuccess extends AssetFileState {
  final SelectedImagesDetails selectedImages;

  const AssetFileSuccess({required this.selectedImages});
}

final class AssetFileError extends AssetFileState {}
