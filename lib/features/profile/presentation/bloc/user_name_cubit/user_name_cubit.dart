import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_username_exist.dart';

part 'user_name_state.dart';

class UserNameCubit extends Cubit<UserNameState> {
  final CheckUsernameExistUseCasse _checkUsernameExistUseCasse;

  UserNameCubit(this._checkUsernameExistUseCasse)
      : super(UserNameCheckInitial());
  void userNameCheck(String userName) async {
    if (userName.isEmpty) {
      emit(UserNameCheckInitial());
      return;
    }

    emit(UserNamecheckingLoading());

    final result = await _checkUsernameExistUseCasse(
      CheckUsernameExistUseCasseParams(userName: userName),
    );

    result.fold(
      (failure) => emit(UserNameCheckError(failure.message)),
      (success) => emit(
          success ? UserNameAvailableState() : UserNameNotAvailableState()),
    );
  }
}
