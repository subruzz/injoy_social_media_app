part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class AuthFailure extends AuthState{}
final class AuthLoggedInOrUpdate extends AuthState {
  final AppUser user;

  const AuthLoggedInOrUpdate({required this.user});
}

final class AuthNotLoggedIn extends AuthState {}

final class AuthLoggedInButProfileNotSet extends AuthState {
  final AppUser user;

  const AuthLoggedInButProfileNotSet({required this.user});
}
