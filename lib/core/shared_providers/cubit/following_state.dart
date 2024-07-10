part of 'following_cubit.dart';

abstract class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

class FollowingInitial extends FollowingState {}

class FollowingLoading extends FollowingState {}

class FollowingLoaded extends FollowingState {
  final List<String> following;

  const FollowingLoaded(this.following);

  @override
  List<Object> get props => [following];
}

class FollowingError extends FollowingState {
  final String message;

 const  FollowingError(this.message);

  @override
  List<Object> get props => [message];
}
