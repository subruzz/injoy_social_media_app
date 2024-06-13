import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/bloc/app_user_bloc.dart';
import 'package:social_media_app/core/bloc/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/features/auth/domain/usecases/login_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  final AppUserBloc _appUserBloc;
  LoginBloc(this._loginUserUseCase, this._appUserBloc) : super(LoginInitial()) {
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
      _emitAuthSuccess(success, emit);
    });
  }

  void _emitAuthSuccess(AppUser user, Emitter<LoginState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(LoginSuccess(user: user, isProfileCompleted: user.fullName == null));
  }
}
