part of 'explore_user_cubit.dart';

sealed class ExploreUserState extends Equatable {
  const ExploreUserState();

  @override
  List<Object> get props => [];
}

final class ExploreUserInitial extends ExploreUserState {}

class ExploreUsersLoading extends ExploreUserState {}

class ExploreUsersLoaded extends ExploreUserState {
  final List<PartialUser> suggestedUsers;
  
  const ExploreUsersLoaded({
    required this.suggestedUsers,
  });
  @override
  List<Object> get props => [];
}

class ExploreUsersError extends ExploreUserState {
  final String message;

  const ExploreUsersError(this.message);
}
