import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/usecases/google_auth.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final AppUserBloc _appUserBloc;

  final GoogleAuthUseCase _googleAuthUseCase;
  GoogleAuthBloc(this._googleAuthUseCase, this._appUserBloc)
      : super(GoogleAuthInitial()) {
    on<GoogleAuthStartEvent>(_googleAuthStartEvent);
  }

  FutureOr<void> _googleAuthStartEvent(
      GoogleAuthStartEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    final res = await _googleAuthUseCase(NoParams());
    res.fold(
        (failure) => emit(GoogleAuthFailure(
            errorMsg: failure.message, details: failure.details)),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _emitAuthSuccess(AppUser user, Emitter<GoogleAuthState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(GoogleAuthSuccess(
      user: user,
    ));
  }
}
