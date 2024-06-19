part of 'pick_image_cubit.dart';

@immutable
abstract class PickSingleImageState {}

class PickImageInitial extends PickSingleImageState {}

class PickImageLoading extends PickSingleImageState {}

class PickImageSuccess extends PickSingleImageState {}

class PickImageFailure extends PickSingleImageState {
  final String error;

  PickImageFailure(this.error);
}
