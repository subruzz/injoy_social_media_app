import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/usecases/google_auth.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  final GoogleAuthUseCase _googleAuthUseCase;
  GoogleAuthBloc(this._googleAuthUseCase) : super(GoogleAuthInitial()) {
    on<GoogleAuthStartEvent>(_googleAuthStartEvent);
  }

  FutureOr<void> _googleAuthStartEvent(
      GoogleAuthStartEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    final res = await _googleAuthUseCase(NoParams());
    res.fold(
      (failure) => GoogleAuthFailure(
          errorMsg: failure.message, details: failure.details),
      (success) => emit(
        GoogleAuthSuccess(user: success),
      ),
    );
  }
}
