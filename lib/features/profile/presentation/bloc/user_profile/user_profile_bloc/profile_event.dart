import 'dart:io';
import 'dart:typed_data';

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
  final String dob;
  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final File? profilePic;
  final Uint8List? webImage;

  final String uid;
  const ProfileSetUpUserDetailsEvent({
    required this.fullName,
    required this.dob,
    required this.webImage,
    required this.phoneNumber,
    required this.occupation,
    required this.about,
    required this.profilePic,
    required this.uid,
  });

  @override
  List<Object> get props => [
        fullName,
        if (phoneNumber != null) phoneNumber!,
        if (occupation != null) occupation!,
        if (about != null) about!,
        if (profilePic != null) profilePic!,
      ];
}

class ProfileInterestSelectedEvent extends ProfileEvent {
  final List<String> interests;
  final bool isEdit;
  final String myId;
  @override
  List<Object> get props => [interests];
  const ProfileInterestSelectedEvent(
      {required this.interests, this.isEdit = false, required this.myId});
}

final class CompleteProfileSetup extends ProfileEvent {
  final UserLocation? location;
  final String uid;
  final String userName;
  const CompleteProfileSetup(
      {this.location, required this.uid, required this.userName});
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
  final String dob;

  const DateOfBirthSelected({required this.dob});
}

class UpdateProfilEvent extends ProfileEvent {
  final String fullName;

  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final String? userProfil;
  final File? profilePic;
  final String uid;
  final UserLocation? location;
  final Uint8List? webImg;
  const UpdateProfilEvent(
      {required this.fullName,
      this.userProfil,
      this.webImg,
      required this.phoneNumber,
      required this.occupation,
      required this.about,
      required this.profilePic,
      required this.uid,
      this.location});
}
