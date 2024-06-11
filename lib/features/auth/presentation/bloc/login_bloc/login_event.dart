part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUserEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginUserEvent({
    required this.email,
    required this.password,
  });
}
