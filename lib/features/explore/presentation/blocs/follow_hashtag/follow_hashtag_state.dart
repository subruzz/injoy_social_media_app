part of 'follow_hashtag_cubit.dart';

sealed class FollowHashtagState extends Equatable {
  const FollowHashtagState();

  @override
  List<Object> get props => [];
}

final class FollowHashtagInitial extends FollowHashtagState {}

class FollowHashtagLoading extends FollowHashtagState {}

class FollowHashtagSuccess extends FollowHashtagState {}

class FollowHashtagFailure extends FollowHashtagState {
  final String error;
  const FollowHashtagFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class FollowHashtagFollowing extends FollowHashtagState {}

class FollowHashtagNotFollowing extends FollowHashtagState {}
