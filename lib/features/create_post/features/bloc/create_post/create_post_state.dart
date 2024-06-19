part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePostState {}

final class CreatePostSuccess extends CreatePostState {}

final class CreatePostFailure extends CreatePostState {
  final String errorMsg;

  const CreatePostFailure({required this.errorMsg});
}

final class CreatePostLoading extends CreatePostState {}
