part of 'get_user_liked_posts_cubit.dart';

sealed class GetUserLikedPostsState extends Equatable {
  const GetUserLikedPostsState();

  @override
  List<Object> get props => [];
}

final class GetUserLikedPostsInitial extends GetUserLikedPostsState {}
final class GetUserLikedPostsLoading extends GetUserLikedPostsState {}

final class GetUserLikedPostsError extends GetUserLikedPostsState {
  final String errorMsg;

  const GetUserLikedPostsError({required this.errorMsg});
}

final class GetUserLikedPostsSuccess extends GetUserLikedPostsState {
  final List<PostEntity> userLikePosts;

  const GetUserLikedPostsSuccess({
    required this.userLikePosts,
  });
}