part of 'like_post_bloc.dart';

sealed class LikePostEvent extends Equatable {
  const LikePostEvent();

  @override
  List<Object> get props => [];
}

final class LikePostClickEvent extends LikePostEvent {
  final String postId;

  const LikePostClickEvent({required this.postId});
}
