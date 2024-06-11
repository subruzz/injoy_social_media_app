part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgetPasswordFailure extends ForgotPasswordState {
  final String errorMsg;
  final String details;
  const ForgetPasswordFailure({required this.errorMsg, required this.details});
}

final class ForgetPasswordLoadingState extends ForgotPasswordState {}

final class ForgetPasswordSuccessState extends ForgotPasswordState {}
