part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final AppUser user;
  const SignupSuccess({required this.user});
}

final class SignupFailure extends SignupState {
  final String errorMsg;
  final String details;
  const SignupFailure({required this.errorMsg, required this.details});
}
