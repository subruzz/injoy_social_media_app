part of 'following_post_feed_bloc.dart';

sealed class FollowingPostFeedEvent extends Equatable {
  const FollowingPostFeedEvent();

  @override
  List<Object> get props => [];
}

class FollowingPostFeedGetEvent extends FollowingPostFeedEvent {
  final String uId;
  final bool isLoadMore;
  final DocumentSnapshot? lastDoc;
  final List<String> following;

  const FollowingPostFeedGetEvent(
      {required this.uId,
      required this.isLoadMore,
      required this.lastDoc,
      required this.following});
}

class GetAllUsers extends FollowingPostFeedEvent {
  final String id;
  final List<String> following;

  const GetAllUsers({required this.id, required this.following});
}
