import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetUpUserDetailsEvent extends ProfileEvent {
  final String fullName;
  final String userName;
  final String dob;
  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final File? profilePic;
  final String uid;
  const ProfileSetUpUserDetailsEvent({
    required this.fullName,
    required this.userName,
    required this.dob,
    required this.phoneNumber,
    required this.occupation,
    required this.about,
    required this.profilePic,
    required this.uid,
  });

  @override
  List<Object> get props => [
        fullName,
        userName,
        if (phoneNumber != null) phoneNumber!,
        if (occupation != null) occupation!,
        if (about != null) about!,
        if (profilePic != null) profilePic!,
      ];
}

class ProfileInterestSelectedEvent extends ProfileEvent {
  final List<String> interests;
  @override
  List<Object> get props => [interests];
  const ProfileInterestSelectedEvent({required this.interests});
}

final class CompleteProfileSetup extends ProfileEvent {
  final UserLocation? location;
  final String uid;

  const CompleteProfileSetup({ this.location, required this.uid});
}

class ProfileSetUpLocationEvent extends ProfileEvent {
  final AppUser userProfile;
  final File? profilePic;
  const ProfileSetUpLocationEvent({
    required this.userProfile,
    this.profilePic,
  });

  @override
  List<Object> get props => [];
}

class ProfileSubmitEvent extends ProfileEvent {}

class DateOfBirthSelected extends ProfileEvent {
  final Future<String?> Function() onDateSelected;

  const DateOfBirthSelected({required this.onDateSelected});
}

class UserNameExistCheckEvent extends ProfileEvent {
  final String userName;

  const UserNameExistCheckEvent({required this.userName});
}
