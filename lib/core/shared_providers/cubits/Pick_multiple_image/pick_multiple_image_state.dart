part of 'pick_multiple_image_cubit.dart';

@immutable
abstract class PickMultipleImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageInitial extends PickMultipleImageState {}

class PickImageLoading extends PickMultipleImageState {}

class PickImageSuccess extends PickMultipleImageState {
  final List<AssetEntity> images;
  @override
  List<Object> get props => [images];
  PickImageSuccess({
    required this.images,
  });
}

class PickImageFailure extends PickMultipleImageState {
  final String error;

  PickImageFailure(this.error);
}
