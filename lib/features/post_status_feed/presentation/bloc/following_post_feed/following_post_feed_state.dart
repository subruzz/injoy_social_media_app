part of 'following_post_feed_bloc.dart';

sealed class FollowingPostFeedState extends Equatable {
  const FollowingPostFeedState();

  @override
  List<Object> get props => [];
}

final class FollowingPostFeedInitial extends FollowingPostFeedState {}

final class FollowingPostFeedLoading extends FollowingPostFeedState {}

final class FollowingPostFeedError extends FollowingPostFeedState {
  final String errorMsg;

  const FollowingPostFeedError({required this.errorMsg});
}

final class FollowingPostFeedSuccess extends FollowingPostFeedState {
  final List<PostEntity> followingPosts;

  const FollowingPostFeedSuccess({
    required this.followingPosts,
  });
}
