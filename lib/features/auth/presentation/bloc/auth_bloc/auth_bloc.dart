// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/utils/shared_preference/app_language.dart';
import 'package:social_media_app/features/auth/domain/usecases/current_user.dart';
import 'package:social_media_app/features/auth/domain/usecases/logout_user.dart';

import '../../../../../core/common/shared_providers/blocs/app_user/app_user_event.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrentUser _currentUser;
  final AppUserBloc _appUserBloc;
  final LogoutUserUseCase _logoutUserUseCase;
  AuthBloc(this._currentUser, this._appUserBloc, this._logoutUserUseCase)
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<AuthCurrentUser>(_authCurrentUser);
    on<LogoutUser>(_logoutUser);
  }

  FutureOr<void> _authCurrentUser(
      AuthCurrentUser event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((failure) => emit(AuthNotLoggedIn()), (success) {
      if (success.userName == null) {
        emit(AuthLoggedInButProfileNotSet(user: success));
        _appUserBloc.add(UpdateUserModelEvent(userModel: success));
      } else {
        emit(AuthLoggedInOrUpdate(user: success));
        _appUserBloc.add(UpdateUserModelEvent(userModel: success));
      }
    });
  }

  FutureOr<void> _logoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res =
        await _logoutUserUseCase(LogoutUserUseCaseParams(userId: event.uId));
    res.fold((failure) => emit(AuthFailure()), (success) {
      emit(AuthNotLoggedIn());
    });
  }
}
