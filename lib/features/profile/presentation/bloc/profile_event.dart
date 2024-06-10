import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSetUpUserDetailsEvent extends ProfileEvent {
  final String fullName;
  final String userName;
  final String dob;
  final int? phoneNumber;
  final String? occupation;
  final String? about;
  final File? profilePic;

  const ProfileSetUpUserDetailsEvent({
    required this.fullName,
    required this.userName,
    required this.dob,
    required this.phoneNumber,
    required this.occupation,
    required this.about,
    required this.profilePic,
  });

  @override
  List<Object> get props => [
        fullName,
        userName,
        dob,
        if (phoneNumber != null) phoneNumber!,
        if (occupation != null) occupation!,
        if (about != null) about!,
        if (profilePic != null) profilePic!,
      ];
}

class ProfileSetUpInterestsEvent extends ProfileEvent {
  final List<String> interests;
  final UserProfile userProfile;
  final File? profilePic;
  const ProfileSetUpInterestsEvent(
      {required this.interests, required this.userProfile, this.profilePic});

  @override
  List<Object> get props => [interests];
}

class ProfileSetUpLocationEvent extends ProfileEvent {
  final String location;
  final double latitude;
  final double longitude;
  final UserProfile userProfile;
  final File? profilePic;
  const ProfileSetUpLocationEvent({
    required this.userProfile,
    this.profilePic,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [location, latitude, longitude];
}

class ProfileSubmitEvent extends ProfileEvent {}
