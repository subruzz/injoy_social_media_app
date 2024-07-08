part of 'get_other_user_posts_cubit.dart';

sealed class GetOtherUserPostsState extends Equatable {
  const GetOtherUserPostsState();

  @override
  List<Object> get props => [];
}

final class GetOtherUserPostsInitial extends GetOtherUserPostsState {}

final class GetOtherUserPostsLoading extends GetOtherUserPostsState {}

final class GetOtherUserPostsError extends GetOtherUserPostsState {
  final String errorMsg;

  const GetOtherUserPostsError({required this.errorMsg});
}

final class GetOtherUserPostsSuccess extends GetOtherUserPostsState {
  final List<PostEntity> userPosts;
  final List<String> userAllPostImages;

  const GetOtherUserPostsSuccess({
    required this.userPosts,
    required this.userAllPostImages,
  });
}
