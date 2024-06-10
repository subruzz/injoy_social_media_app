import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/bloc/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';
import 'package:social_media_app/features/auth/domain/usecases/current_user.dart';

part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  final CurrentUser _currentUser;
  AppUserBloc(this._currentUser) : super(AppUserInitial()) {
    on<UpdateUserModelEvent>(
      (event, emit) {
        final user = event.userModel;
        if (user == null) {
          emit(AppUserInitial());
        } else {
          emit(AppUserLoggedIn(user: user));
        }
      },
    );
    on<AppGetCurrentUser>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold((failure) => emit(UserModelNotFoundState()),
          (success) => emit(AppUserLoggedIn(user: success)));
    });
  }
}
