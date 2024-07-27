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
  const LikePostClickEvent({
    required this.user,
    required this.postId,
    required this.otherUserId,
  });
}

final class UnlikePostClickEvent extends LikePostEvent {
  final String postId;
  final String myId;
  final String ohterUseId;

  const UnlikePostClickEvent({
    required this.postId,
    required this.myId,
    required this.ohterUseId,
  });
}
