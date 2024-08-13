import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/profile_usecases/add_interest.dart';
import 'package:social_media_app/features/profile/domain/usecases/profile_usecases/check_username_exist.dart';
import 'package:social_media_app/features/profile/domain/usecases/profile_usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/index.dart';
// import 'package:stream_transform/stream_transform.dart';

// const _duration = Duration(milliseconds: 500);

// EventTransformer<Event> debounce<Event>(Duration duration) {
//   return (events, mapper) => events.debounce(duration).switchMap(mapper);
// }

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppUserBloc _appUserBloc;
  final CreateUserProfileUseCase _createUserProfileUseCase;
  final AddInterestUseCase _addInterestUseCase;
  ProfileBloc(this._createUserProfileUseCase, this._appUserBloc,
      this._addInterestUseCase)
      : super(ProfileInitial()) {
    on<ProfileSetUpUserDetailsEvent>(_onUserDetailsSet);
    on<ProfileInterestSelectedEvent>(_onInterestsSet);
    // on<ProfileSetUpLocationEvent>(_onLocationSet);
    on<DateOfBirthSelected>(_onDateOfBirthSelected);
    on<CompleteProfileSetup>(_completeProfileSetup);
    on<UpdateProfilEvent>(_updateProfile);
  }
  String _fullName = '';
  String _dob = '';
  String? _phoneNum;
  String? _about;
  String? _occupation;
  File? _fileImg;
  List<String> _interest = [];

  FutureOr<void> _onDateOfBirthSelected(
      DateOfBirthSelected event, Emitter<ProfileState> emit) async {
    if (event.dob.isEmpty) return;
    _dob = event.dob;
    emit(DateOfBirthSet(dateOfBirth: event.dob));
  }

  FutureOr<void> _onUserDetailsSet(
      ProfileSetUpUserDetailsEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileSetUpLoading());
    _fileImg = event.profilePic;
    _fullName = event.fullName;
    _phoneNum = event.phoneNumber;
    _dob = event.dob;
    _about = event.about;
    _occupation = event.occupation;
    emit(ProfileSetupSuccess());
  }

  FutureOr<void> _onInterestsSet(
      ProfileInterestSelectedEvent event, Emitter<ProfileState> emit) async {
    if (!event.isEdit) _interest = event.interests;
    emit(ProfileInterestLoading());
    if (event.interests.isEmpty) {
      emit(ProfileInterestEmptyState());
      return;
    }
    if (event.isEdit) {
      final res = await _addInterestUseCase(AddInterestUseCaseParams(
          interests: event.interests, uid: event.myId));
      res.fold(
          (failure) => emit(ProfileInterestsFailure(error: failure.message)),
          (success) => emit(const ProfileInterestsSet(isEdit: true)));
      return;
    }

    emit(const ProfileInterestsSet());
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

  FutureOr<void> _completeProfileSetup(
      CompleteProfileSetup event, Emitter<ProfileState> emit) async {
    emit(CompleteProfileSetupLoading());
    final UserProfile userProfile = UserProfile(
        fullName: _fullName,
        dob: _dob,
        userName: event.userName,
        phoneNumber: _phoneNum?.isEmpty ?? true ? null : _phoneNum,
        occupation: _occupation?.isEmpty ?? true ? null : _occupation,
        about: _about?.isEmpty ?? true ? null : _about,
        interests: _interest,
        latitude: event.location?.latitude,
        longitude: event.location?.longitude,
        location: event.location?.currentLocation);
    log(userProfile.toString());
    final res = await _createUserProfileUseCase(CreateUserProfileUseCaseParams(
        isEdit: false,
        appUser: userProfile,
        uid: event.uid,
        profilePic: _fileImg));
    res.fold((failure) {
      log('error occured in bloc');
      emit(CompleteProfileSetupFailure(errorMsg: failure.message));
    }, (success) => _updateTheCurrentUser(success, emit));
  }

  void _updateTheCurrentUser(AppUser user, Emitter<ProfileState> emit) {
    _appUserBloc.add(UpdateUserModelEvent(userModel: user));
    emit(CompleteProfileSetupSuceess(appUser: user));
  }

  FutureOr<void> _updateProfile(
      UpdateProfilEvent event, Emitter<ProfileState> emit) async {
    log(event.phoneNumber ?? '');
    emit(CompleteProfileSetupLoading());

    final UserProfile userProfile = UserProfile(
        dob: '',
        fullName: event.fullName,
        profilePic: event.userProfil,
        phoneNumber:
            event.phoneNumber?.isEmpty ?? true ? null : event.phoneNumber,
        occupation: event.occupation?.isEmpty ?? true ? null : event.occupation,
        about: event.about?.isEmpty ?? true ? null : event.about,
        latitude: event.location?.latitude,
        longitude: event.location?.longitude,
        location: event.location?.currentLocation);
    final res = await _createUserProfileUseCase(CreateUserProfileUseCaseParams(
        isEdit: true,
        appUser: userProfile,
        uid: event.uid,
        profilePic: event.profilePic));
    res.fold((failure) {
      log('error occured in bloc');
      emit(CompleteProfileSetupFailure(errorMsg: failure.message));
    }, (success) => _updateTheCurrentUser(success, emit));
  }
}
