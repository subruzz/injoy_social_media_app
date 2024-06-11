import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/auth/domain/usecases/forgot_password.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordBloc(this._forgotPasswordUseCase)
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) {
      emit(ForgetPasswordLoadingState());
    });
    on<ForgotPassWordResetEvent>(_forgotPassWordEvent);
  }

  FutureOr<void> _forgotPassWordEvent(
      ForgotPassWordResetEvent event, Emitter<ForgotPasswordState> emit) async {
    final res = await _forgotPasswordUseCase(
      ForgotPasswordUseCaseParams(email: event.email),
    );
    res.fold(
      (failure) => emit(ForgetPasswordFailure(
          errorMsg: failure.message, details: failure.details)),
      (success) => emit(
        ForgetPasswordSuccessState(),
      ),
    );
  }
}
