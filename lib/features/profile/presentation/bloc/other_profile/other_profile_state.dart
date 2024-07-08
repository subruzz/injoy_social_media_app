part of 'other_profile_cubit.dart';

sealed class OtherProfileState extends Equatable {
  const OtherProfileState();

  @override
  List<Object> get props => [];
}

final class OtherProfileInitial extends OtherProfileState {}

final class OtherProfileLoading extends OtherProfileState {}

final class OtherProfileError extends OtherProfileState {
  final String error;

  const OtherProfileError({required this.error});
}

final class OtherProfileSuccess extends OtherProfileState {
  final AppUser userProfile;

  const OtherProfileSuccess({required this.userProfile});
}
