part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
  @override
  List<Object> get props => [];
}

final class ForgotPassWordResetEvent extends ForgotPasswordEvent {
  final String email;
  const ForgotPassWordResetEvent({required this.email});
}
