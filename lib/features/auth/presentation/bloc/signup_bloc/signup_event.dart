part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

final class SignupUserEvent extends SignupEvent {
  final String email;
  final String password;

  const SignupUserEvent({
    required this.email,
    required this.password,
  });
}
