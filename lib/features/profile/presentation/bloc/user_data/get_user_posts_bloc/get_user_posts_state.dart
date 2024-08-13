part of 'get_user_posts_bloc.dart';

sealed class GetUserPostsState extends Equatable {
  const GetUserPostsState();

  @override
  List<Object> get props => [];
}

final class GetUserPostsInitial extends GetUserPostsState {}

final class GetUserPostsLoading extends GetUserPostsState {}

final class GetUserPostsError extends GetUserPostsState {
  final String errorMsg;

  const GetUserPostsError({required this.errorMsg});
}

final class GetUserPostsSuccess extends GetUserPostsState {
  final List<PostEntity> userPosts;

  const GetUserPostsSuccess({
    required this.userPosts,
  });
}
