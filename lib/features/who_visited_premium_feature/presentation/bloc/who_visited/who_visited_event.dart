part of 'who_visited_bloc.dart';

sealed class WhoVisitedEvent extends Equatable {
  const WhoVisitedEvent();

  @override
  List<Object> get props => [];
}

final class AddUserToVisited extends WhoVisitedEvent {
  final String myId;
  final String visitedUserId;

  const AddUserToVisited({required this.myId, required this.visitedUserId});
}

final class GetAllVisitedUser extends WhoVisitedEvent {
  final String myId;

  const GetAllVisitedUser({required this.myId});
}
