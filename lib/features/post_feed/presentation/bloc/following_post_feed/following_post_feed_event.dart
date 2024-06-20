part of 'following_post_feed_bloc.dart';

sealed class FollowingPostFeedEvent extends Equatable {
  const FollowingPostFeedEvent();

  @override
  List<Object> get props => [];
}

class FollowingPostFeedGetEvent extends FollowingPostFeedEvent {
  final String uId;

  const FollowingPostFeedGetEvent({required this.uId});
}
