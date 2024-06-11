import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/features/auth/domain/usecases/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  LoginBloc(this._loginUserUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      emit(LoginLoading());
    });

    on<LoginUserEvent>(_loginUserEvent);
  }

  FutureOr<void> _loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    final res = await _loginUserUseCase(
      LoginUserUseCaseParams(email: event.email, password: event.password),
    );
    res.fold(
        (failure) => emit(
              LoginFailure(errorMsg: failure.message, details: failure.details),
            ), (success) {
      final isprofileCompleted = success.fullName == null ? false : true;
      emit(
        LoginSuccess(user: success, isProfileCompleted: isprofileCompleted),
      );
    });
  }
}
