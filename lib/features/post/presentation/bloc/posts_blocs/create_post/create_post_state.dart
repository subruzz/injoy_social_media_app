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

class PostDeletionLoading extends CreatePostState {}

class PostDeletionSuccess extends CreatePostState {}

class PostDeletionFailure extends CreatePostState {}

final class UpdatePostLoading extends CreatePostState {}

final class UpdatePostSuccess extends CreatePostState {
  final PostEntity updatedPost;

 const  UpdatePostSuccess({required this.updatedPost});
}

final class UpdatePostsError extends CreatePostState {}
