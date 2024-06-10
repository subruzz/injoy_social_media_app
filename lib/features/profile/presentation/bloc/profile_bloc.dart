import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final CreateUserProfileUseCase _createUserProfileUseCase;
  ProfileBloc(this._createUserProfileUseCase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileSetUpUserDetailsEvent>(_onUserDetailsSet);
    on<ProfileSetUpInterestsEvent>(_onInterestsSet);
    on<ProfileSetUpLocationEvent>(_onLocationSet);
  }

  FutureOr<void> _onUserDetailsSet(
      ProfileSetUpUserDetailsEvent event, Emitter<ProfileState> emit) {
    UserProfile userProfile = UserProfile(
      fullName: event.fullName,
      userName: event.userName,
      dob: event.dob,
      phoneNumber: event.phoneNumber,
      occupation: event.occupation,
      about: event.about,
    );
    emit(
      ProfileUserDetailsSet(userProfile, event.profilePic),
    );
  }

  FutureOr<void> _onInterestsSet(
      ProfileSetUpInterestsEvent event, Emitter<ProfileState> emit) {
    event.userProfile.interests = event.interests;
    print(event.profilePic);
    emit(
      ProfileInterestsSet(event.userProfile, event.profilePic),
    );
  }

  FutureOr<void> _onLocationSet(
      ProfileSetUpLocationEvent event, Emitter<ProfileState> emit) async {
    event.userProfile.latitude = event.latitude;
    event.userProfile.location = event.location;
    event.userProfile.longitude = event.longitude;
    final userProfile = event.userProfile;
    final result = await _createUserProfileUseCase(
      CreateUserProfileUseCaseParams(
          fullName: userProfile.fullName,
          userName: userProfile.userName,
          dob: userProfile.dob,
          phoneNumber: userProfile.phoneNumber,
          occupation: userProfile.occupation,
          about: userProfile.about,
          profilePic: event.profilePic,
          location: userProfile.location,
          latitude: userProfile.latitude,
          interests: userProfile.interests,
          longitude: userProfile.longitude),
    );
    result.fold((failure) => emit(ProfileSubmissionFailure(failure.message)),
        (success) => emit(ProfileSubmissionSuccess()));
  }
}
