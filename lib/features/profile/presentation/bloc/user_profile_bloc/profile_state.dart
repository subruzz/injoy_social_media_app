import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

//basic profile adding
class ProfileInitial extends ProfileState {}

class ProfileSubmissionFailure extends ProfileState {
  final String error;

  const ProfileSubmissionFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class ProfileSetUpLoading extends ProfileState {}

class ProfileSetupSuccess extends ProfileState {}

final class CompleteProfileSetupLoading extends ProfileState {}

final class CompleteProfileSetupFailure extends ProfileState {
  final String errorMsg;

  const CompleteProfileSetupFailure({required this.errorMsg});
}

final class CompleteProfileSetupSuceess extends ProfileState {
  final AppUser appUser;

  const CompleteProfileSetupSuceess({required this.appUser});
}

//user interest selecing
class ProfileInterestsSet extends ProfileState {
  final bool isEdit;

  const ProfileInterestsSet({this.isEdit = false});
}

class ProfileInterestsFailure extends ProfileState {
  final String error;

  const ProfileInterestsFailure({required this.error});
}

class ProfileInterestLoading extends ProfileState {}

class ProfileInterestEmptyState extends ProfileState {}

final class ProfileInterstLoading extends ProfileState {}

//location seleting event
class ProfileLocationSet extends ProfileState {
  final UserProfile userProfile;
  const ProfileLocationSet(
    this.userProfile,
  );

  @override
  List<Object> get props => [userProfile];
}

//username availability checking
class UserNameAvailabelState extends ProfileState {}

class UserNameNotAvailabelState extends ProfileState {}

class UserNamecheckingLoading extends ProfileState {}

class UserNameCheckInitial extends ProfileState {}

class UserNameCheckError extends ProfileState {
  final String error;

  const UserNameCheckError(this.error);

  @override
  List<Object> get props => [error];
}

//date of birth selecting
class DateOfBirthSet extends ProfileState {
  final String dateOfBirth;
  const DateOfBirthSet({required this.dateOfBirth});
  @override
  List<Object> get props => [dateOfBirth];
}

class DateOfBirthNotSelect extends ProfileState {
  const DateOfBirthNotSelect();
}
