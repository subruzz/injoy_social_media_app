part of 'user_name_cubit.dart';

sealed class UserNameState extends Equatable {
  const UserNameState();

  @override
  List<Object> get props => [];
}

class UserNameAvailableState extends UserNameState {}

class UserNameNotAvailableState extends UserNameState {}

class UserNamecheckingLoading extends UserNameState {}

class UserNameCheckInitial extends UserNameState {}

class UserNameCheckError extends UserNameState {
  final String error;

  const UserNameCheckError(this.error);

  @override
  List<Object> get props => [error];
}