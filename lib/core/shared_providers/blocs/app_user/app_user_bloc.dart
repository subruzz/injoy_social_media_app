import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  AppUserBloc() : super(AppUserInitial()) {
    on<UpdateUserModelEvent>(
      (event, emit) {
        emit(AppUserLoading());
        _appUser = event.userModel;
        if (_appUser == null) {
          emit(AppUserInitial());
        } else {
          emit(AppUserLoggedIn(user: appUser!));
        }
      },
    );
  }
}
