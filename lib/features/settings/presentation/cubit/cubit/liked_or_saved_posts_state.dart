part of 'liked_or_saved_posts_cubit.dart';

sealed class LikedOrSavedPostsState extends Equatable {
  const LikedOrSavedPostsState();

  @override
  List<Object> get props => [];
}

final class LikedOrSavedPostsInitial extends LikedOrSavedPostsState {}

final class LikedOrSavedPostsSuccess extends LikedOrSavedPostsState {
  final List<PostEntity> likedOrSavedPosts;

  const LikedOrSavedPostsSuccess({required this.likedOrSavedPosts});
}

final class LikedOrSavedPostsLoading extends LikedOrSavedPostsState {}

final class LikedOrSavedPostsFailure extends LikedOrSavedPostsState {}
