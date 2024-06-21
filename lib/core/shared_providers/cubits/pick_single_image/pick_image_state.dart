part of 'pick_image_cubit.dart';

@immutable
abstract class PickSingleImageState {}

class PickSingleImageInitial extends PickSingleImageState {}

class PickSingleImageLoading extends PickSingleImageState {}

class PickSingleImageSuccess extends PickSingleImageState {
  final File img;

  PickSingleImageSuccess({required this.img});
}

class PickSingleImageFailure extends PickSingleImageState {
  final String error;

  PickSingleImageFailure(this.error);
}
