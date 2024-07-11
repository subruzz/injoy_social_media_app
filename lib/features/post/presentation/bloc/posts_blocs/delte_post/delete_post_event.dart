part of 'delete_post_bloc.dart';

sealed class DeletePostEvent extends Equatable {
  const DeletePostEvent();

  @override
  List<Object> get props => [];
}

final class DeletePost extends DeletePostEvent {
  final String postId;

  const DeletePost({required this.postId});
}
