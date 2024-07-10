part of 'like_post_bloc.dart';

sealed class LikePostEvent extends Equatable {
  const LikePostEvent();

  @override
  List<Object> get props => [];
}

final class LikePostClickEvent extends LikePostEvent {
  final String postId;
  final String currentUserId;

  const LikePostClickEvent({
    required this.postId,
    required this.currentUserId,
  });
}

final class UnlikePostClickEvent extends LikePostEvent {
  final String postId;
  final String currentUserId;

  const UnlikePostClickEvent({
    required this.postId,
    required this.currentUserId,
  });
}
