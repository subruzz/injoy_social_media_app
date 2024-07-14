part of 'get_followers_cubit.dart';

sealed class GetFollowersState extends Equatable {
  const GetFollowersState();

  @override
  List<Object> get props => [];
}

final class GetFollowersInitial extends GetFollowersState {}

class FollowersListLoading extends GetFollowersState {}

class FollowersListLoaded extends GetFollowersState {
  final List<PartialUser> followers;

  const FollowersListLoaded(this.followers);

  @override
  List<Object> get props => [followers];
}

class FollowersListError extends GetFollowersState {
  final String message;

  const FollowersListError(this.message);

  @override
  List<Object> get props => [message];
}
