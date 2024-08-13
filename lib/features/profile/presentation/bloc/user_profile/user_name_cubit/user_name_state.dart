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

class AddUserNameLoading extends UserNameState {}

class AddUserNameSuccess extends UserNameState {
  final String userName;

  const AddUserNameSuccess({required this.userName});
}

class AddUserNameFailure extends UserNameState {
  final String error;

  const AddUserNameFailure({required this.error});
}
