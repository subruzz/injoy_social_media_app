import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/auth/domain/usecases/user_signup.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AppUserBloc _appUserBloc;
  final UserSignup _userSignUp;
  SignupBloc({required UserSignup userSignUp, required AppUserBloc appUserBloc})
      : _userSignUp = userSignUp,
        _appUserBloc = appUserBloc,
        super(
          SignupInitial(),
        ) {
    on<SignupEvent>(
      (event, emit) {
        emit(SignupLoading());
      },
    );
    on<SignupUserEvent>(_signupUserEvent);
  }

  FutureOr<void> _signupUserEvent(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    final result = await _userSignUp(
      UserSignUpParams(email: event.email, password: event.password),
    );
    result.fold(
        (failure) => emit(
              SignupFailure(
                  errorMsg: failure.message, details: failure.details),
            ),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _emitAuthSuccess(AppUser user, Emitter<SignupState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(SignupSuccess(user: user));
  }
}
