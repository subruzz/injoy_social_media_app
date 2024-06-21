// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/usecases/current_user.dart';

import '../../../../../core/shared_providers/blocs/app_user/app_user_event.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrentUser _currentUser;
  final AppUserBloc _appUserBloc;
  AuthBloc(this._currentUser, this._appUserBloc) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<AuthCurrentUser>(_authCurrentUser);
  }

  FutureOr<void> _authCurrentUser(
      AuthCurrentUser event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((failure) => emit(AuthNotLoggedIn()), (success) {
      if (success.fullName == null) {
        emit(AuthLoggedInButProfileNotSet(user: success));
      } else {
        emit(AuthLoggedInOrUpdate(user: success));
        _appUserBloc.add(UpdateUserModelEvent(userModel: success));
      }
    });
  }
}
