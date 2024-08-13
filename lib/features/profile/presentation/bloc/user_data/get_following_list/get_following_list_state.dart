part of 'get_following_list_cubit.dart';

sealed class GetFollowingListState extends Equatable {
  const GetFollowingListState();

  @override
  List<Object> get props => [];
}

final class GetFollowingListInitial extends GetFollowingListState {}

class FollowingListLoading extends GetFollowingListState {}

class FollowingListLoaded extends GetFollowingListState {
  final List<PartialUser> following;

  const FollowingListLoaded(this.following);

  @override
  List<Object> get props => [following];
}

class FollowingListError extends GetFollowingListState {
  final String message;

  const FollowingListError(this.message);

  @override
  List<Object> get props => [message];
}
