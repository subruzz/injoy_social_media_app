import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/check_username_exist.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUserBloc _appUserBloc;
  final CheckUsernameExistUseCasse _checkUsernameExistUseCasse;
  final CreateUserProfileUseCase _createUserProfileUseCase;
  ProfileBloc(this._createUserProfileUseCase, this._appUserBloc,
      this._checkUsernameExistUseCasse)
      : super(ProfileInitial()) {
    on<UserNameExistCheckEvent>(_checkUserNameAvailableOrNot,
        transformer: debounce(_duration));
    on<ProfileSetUpUserDetailsEvent>(_onUserDetailsSet);
    on<ProfileInterestSelectedEvent>(_onInterestsSet);
    // on<ProfileSetUpLocationEvent>(_onLocationSet);
    on<DateOfBirthSelected>(_onDateOfBirthSelected);
    on<CompleteProfileSetup>(_completeProfileSetup);
  }
  String _fullName = '';
  String _userName = '';
  String _dob = '';
  String? _phoneNum;
  String? _about;
  String? _occupation;
  File? _fileImg;
  List<String> _interest = [];

  FutureOr<void> _onDateOfBirthSelected(
      DateOfBirthSelected event, Emitter<ProfileState> emit) async {
    final String? selecteDob = await event.onDateSelected();
    if (selecteDob == null) {
      return;
    }

    emit(DateOfBirthSet(dateOfBirth: selecteDob));
  }

  FutureOr<void> _onUserDetailsSet(
      ProfileSetUpUserDetailsEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileSetUpLoading());
    _fileImg = event.profilePic;
    _fullName = event.fullName;
    _userName = event.userName;
    _dob = event.dob;
    _phoneNum = event.phoneNumber;
    _about = event.about;
    _occupation = event.occupation;
    emit(ProfileSetupSuccess());
  }

  FutureOr<void> _onInterestsSet(
      ProfileInterestSelectedEvent event, Emitter<ProfileState> emit) async {
    _interest = event.interests;
    emit(ProfileInterestLoading());
    if (event.interests.isEmpty) {
      emit(ProfileInterestEmptyState());
      return;
    }

    emit(ProfileInterestsSet());
  }

  // FutureOr<void> _onLocationSet(
  //     ProfileSetUpLocationEvent event, Emitter<ProfileState> emit) async {
  //   final result = await _createUserProfileUseCase(
  //     CreateUserProfileUseCaseParams(
  //         appUser: event.userProfile, profilePic: event.profilePic,uid: event.),
  //   );
  //   result.fold((failure) => emit(ProfileSubmissionFailure(failure.message)),
  //       (success) => _emitAuthSuccess(success, emit));
  // }

  FutureOr<void> _checkUserNameAvailableOrNot(
      UserNameExistCheckEvent event, Emitter<ProfileState> emit) async {
    if (event.userName.isEmpty) {
      emit(UserNameCheckInitial());
      return;
    }

    emit(UserNamecheckingLoading());

    final result = await _checkUsernameExistUseCasse(
      CheckUsernameExistUseCasseParams(userName: event.userName),
    );

    result.fold(
      (failure) => emit(UserNameCheckError(failure.message)),
      (success) => emit(
          success ? UserNameAvailabelState() : UserNameNotAvailabelState()),
    );
  }

  FutureOr<void> _completeProfileSetup(
      CompleteProfileSetup event, Emitter<ProfileState> emit) async {
    emit(CompleteProfileSetupLoading());
    final UserProfile userProfile = UserProfile(
        fullName: _fullName,
        userName: _userName,
        dob: _dob,
        phoneNumber: _phoneNum?.isEmpty ?? true ? null : _phoneNum,
        occupation: _occupation?.isEmpty ?? true ? null : _occupation,
        about: _about?.isEmpty ?? true ? null : _about,
        interests: _interest,
        latitude: event.location?.latitude,
        longitude: event.location?.longitude,
        location: event.location?.currentLocation);
    log(userProfile.toString());
    final res = await _createUserProfileUseCase(CreateUserProfileUseCaseParams(
        appUser: userProfile, uid: event.uid, profilePic: _fileImg));
    res.fold((failure) {
      log('error occured in bloc');
      emit(CompleteProfileSetupFailure(errorMsg: failure.message));
    }, (success) => _updateTheCurrentUser(success, emit));
  }

  void _updateTheCurrentUser(AppUser user, Emitter<ProfileState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(CompleteProfileSetupSuceess(appUser: user));
  }
}
