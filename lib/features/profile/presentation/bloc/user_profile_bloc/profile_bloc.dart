import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUserBloc _appUserBloc;
  final CreateUserProfileUseCase _createUserProfileUseCase;
  ProfileBloc(this._createUserProfileUseCase, this._appUserBloc)
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      emit(ProfileSetUpLoading());
    });

    // on<ProfileSetUpUserDetailsEvent>(_onUserDetailsSet);
    // on<ProfileSetUpInterestsEvent>(_onInterestsSet);
    on<ProfileSetUpLocationEvent>(_onLocationSet);
  }

  // FutureOr<void> _onUserDetailsSet(
  //     ProfileSetUpUserDetailsEvent event, Emitter<ProfileState> emit) {
  //   UserProfile userProfile = UserProfile(
  //     fullName: event.fullName,
  //     userName: event.userName,
  //     dob: event.dob,
  //     phoneNumber: event.phoneNumber,
  //     occupation: event.occupation,
  //     about: event.about,
  //   );
  //   emit(
  //     ProfileUserDetailsSet(userProfile, event.profilePic),
  //   );
  // }

  // FutureOr<void> _onInterestsSet(
  //     ProfileSetUpInterestsEvent event, Emitter<ProfileState> emit) {
  //   event.userProfile.interests = event.interests;
  //   print(event.profilePic);
  //   emit(
  //     ProfileInterestsSet(event.userProfile, event.profilePic),
  //   );
  // }

  FutureOr<void> _onLocationSet(
      ProfileSetUpLocationEvent event, Emitter<ProfileState> emit) async {
    final result = await _createUserProfileUseCase(
      CreateUserProfileUseCaseParams(
          appUser: event.userProfile, profilePic: event.profilePic),
    );
    result.fold((failure) => emit(ProfileSubmissionFailure(failure.message)),
        (success) => _emitAuthSuccess(success, emit));
  }

  void _emitAuthSuccess(AppUser user, Emitter<ProfileState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(ProfileSubmissionSuccess());
  }
}
