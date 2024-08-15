part of 'get_user_posts_bloc.dart';

sealed class GetUserPostsEvent extends Equatable {
  const GetUserPostsEvent();

  @override
  List<Object> get props => [];
}

final class GetUserPostsrequestedEvent extends GetUserPostsEvent {
  final PartialUser user;

  const GetUserPostsrequestedEvent({required this.user});
}

final class GetPostAfterDelete extends GetUserPostsEvent {
  final int index;

  const GetPostAfterDelete({
    required this.index,
  });
}

final class GetUserPostsAterPostUpdate extends GetUserPostsEvent {
  final int index;
  final PostEntity updatedPost;
  const GetUserPostsAterPostUpdate(
      {required this.index, required this.updatedPost});
}
