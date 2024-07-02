part of 'app_user_bloc.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitial extends AppUserState {}

final class AppUserLoading extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final AppUser user;

  @override
  List<Object> get props => [user];
  const AppUserLoggedIn({required this.user});
}

final class UserModelNotFoundState extends AppUserState {}

final class UserExitState extends AppUserState {}
