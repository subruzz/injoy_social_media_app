import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';

part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  late AppUser _appUser;
  AppUser get appUser => _appUser;
  AppUserBloc() : super(AppUserInitial()) {
    on<UpdateUserModelEvent>(
      (event, emit) {
        log('app user initilized');
        _appUser = event.userModel;
        log(_appUser.following.toString());
        emit(AppUserLoggedIn(user: appUser));
      },
    );
    on<UserOnlineStatusUpdate>(_updateUserStatus);
  }

  FutureOr<void> _updateUserStatus(
      UserOnlineStatusUpdate event, Emitter<AppUserState> emit) async {
    FirebaseFirestore.instance.collection('users').doc(_appUser.id).update({
      'onlineStatus': event.status,
      if (!event.status) 'lastSeen': FieldValue.serverTimestamp()
    });
  }
}
