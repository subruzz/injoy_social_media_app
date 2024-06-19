import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/auth/domain/usecases/current_user.dart';

part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  final CurrentUser _currentUser;
  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  AppUserBloc(this._currentUser) : super(AppUserInitial()) {
    on<UpdateUserModelEvent>(
      (event, emit) {
        _appUser = event.userModel;
        if (_appUser == null) {
          emit(AppUserInitial());
        } else {
          emit(AppUserLoggedIn(user: appUser!));
        }
      },
    );
    on<AppGetCurrentUser>((event, emit) async {
      final res = await _currentUser(NoParams());
      res.fold((failure) => emit(UserModelNotFoundState()), (success) {
        _appUser = success;
        emit(AppUserLoggedIn(user: success));
      });
    });
  }
}
