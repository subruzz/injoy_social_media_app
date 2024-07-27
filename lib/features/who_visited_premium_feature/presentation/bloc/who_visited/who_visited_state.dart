part of 'who_visited_bloc.dart';

sealed class WhoVisitedState extends Equatable {
  const WhoVisitedState();

  @override
  List<Object> get props => [];
}

final class WhoVisitedInitial extends WhoVisitedState {}

final class GetVisitedUserLoading extends WhoVisitedState {}

final class GetVisitedUserError extends WhoVisitedState {
  final String error;

const   GetVisitedUserError({required this.error});
}

final class GetVisitedUserSuccess extends WhoVisitedState {
  final List<UserVisit> visitedUsers;

  const GetVisitedUserSuccess({required this.visitedUsers});
}
