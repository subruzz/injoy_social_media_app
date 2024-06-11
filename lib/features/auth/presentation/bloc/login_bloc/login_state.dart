part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AppUser user;
  final bool isProfileCompleted;
  const LoginSuccess({required this.user, required this.isProfileCompleted});
}

final class LoginFailure extends LoginState {
  final String errorMsg;
  final String details;
  const LoginFailure({required this.errorMsg, required this.details});
}