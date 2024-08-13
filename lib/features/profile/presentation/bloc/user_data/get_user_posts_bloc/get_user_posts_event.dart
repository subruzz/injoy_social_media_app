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

final class GetUserPostsAterPostUpdate extends GetUserPostsEvent {
  final PostEntity updatedPost;
  final List<PostEntity> allUsePosts;
  final List<String> userAllPostImages;

  final int index;

  const GetUserPostsAterPostUpdate(
      {required this.updatedPost,
      required this.index,
      required this.userAllPostImages,
      required this.allUsePosts});
}
