part of 'google_auth_bloc.dart';

sealed class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthSuccess extends GoogleAuthState {
  final AppUser user;

  const GoogleAuthSuccess({required this.user});
}

final class GoogleAuthFailure extends GoogleAuthState {
  final String errorMsg;
  final String details;
  const GoogleAuthFailure({required this.errorMsg, required this.details});
}

final class GoogleAuthLoading extends GoogleAuthState {}
