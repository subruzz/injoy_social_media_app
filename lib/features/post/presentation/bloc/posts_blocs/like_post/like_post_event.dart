part of 'like_post_bloc.dart';

sealed class LikePostEvent extends Equatable {
  const LikePostEvent();

  @override
  List<Object> get props => [];
}

final class LikePostClickEvent extends LikePostEvent {
  final String postId;
  final AppUser user;
  final String otherUserId;
  final bool isReel;
  final PostEntity post;

  const LikePostClickEvent({
    required this.post,
    required this.user,
    this.isReel = false,
    required this.postId,
    required this.otherUserId,
  });
}

final class UnlikePostClickEvent extends LikePostEvent {
  final String postId;
  final String myId;
  final String ohterUseId;
  final bool isReel;

  const UnlikePostClickEvent({
    this.isReel = false,
    required this.postId,
    required this.myId,
    required this.ohterUseId,
  });
}
