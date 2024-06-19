part of 'get_user_posts_bloc.dart';

sealed class GetUserPostsEvent extends Equatable {
  const GetUserPostsEvent();

  @override
  List<Object> get props => [];
}

final class GetUserPostsrequestedEvent extends GetUserPostsEvent {
  final String uid;

  const GetUserPostsrequestedEvent({required this.uid});
}
