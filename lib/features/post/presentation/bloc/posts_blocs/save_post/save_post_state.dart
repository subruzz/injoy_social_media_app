part of 'save_post_cubit.dart';

sealed class SavePostState extends Equatable {
  const SavePostState();

  @override
  List<Object> get props => [];
}

final class SavePostInitial extends SavePostState {}

final class SavePostLoading extends SavePostState {}

final class SavePostFailure extends SavePostState {
  final String error;

  const SavePostFailure({required this.error});
}

final class SavePostSuccess extends SavePostState {}
