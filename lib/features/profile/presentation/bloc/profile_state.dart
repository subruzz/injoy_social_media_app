import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

// class ProfileUserDetailsSet extends ProfileState {
//   final UserProfile userProfile;
//   final File? profileImag;
//   const ProfileUserDetailsSet(this.userProfile, this.profileImag);

//   @override
//   List<Object> get props => [userProfile];
// }

final class ProfileSetUpLoading extends ProfileState {}

// class ProfileInterestsSet extends ProfileState {
//   final UserProfile userProfile;
//   final File? profileImag;

//   const ProfileInterestsSet(this.userProfile, this.profileImag);

//   @override
//   List<Object> get props => [userProfile];
// }

class ProfileLocationSet extends ProfileState {
  final UserProfile userProfile;
  final File? profileImage;
  const ProfileLocationSet(this.userProfile, this.profileImage);

  @override
  List<Object> get props => [userProfile];
}

class ProfileSubmissionSuccess extends ProfileState {}

class ProfileSubmissionFailure extends ProfileState {
  final String error;

  const ProfileSubmissionFailure(this.error);

  @override
  List<Object> get props => [error];
}
