part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthCurrentUser extends AuthEvent {}

final class UpdateCurrentUserEvent extends AuthEvent {
  final AppUser? userModel;
  const UpdateCurrentUserEvent({required this.userModel});
}

final class UpdateCurrentUserSignOutEvent extends AuthEvent {}

final class EnsureUserModelExistsEvent extends AuthEvent {}

final class LogoutUser extends AuthEvent {
  final String uId;

  const LogoutUser({required this.uId});
}
