part of 'for_you_post_bloc.dart';

sealed class ForYouPostEvent extends Equatable {
  const ForYouPostEvent();

  @override
  List<Object> get props => [];
}

class ForYouPostFeedGetEvent extends ForYouPostEvent {
  final AppUser user;

  const ForYouPostFeedGetEvent({required this.user});
}
