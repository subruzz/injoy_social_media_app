import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';

import '../../../../domain/usecases/profile_usecases/check_username_exist.dart';

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

  void setSuccess() {
    emit(UserNameAvailableState());
  }

  void setUserName(String userName, final String userId) async {
    try {
      emit(AddUserNameLoading());
      FirebaseFirestore.instance
          .collection(FirebaseCollectionConst.users)
          .doc(userId)
          .update({'userName': userName});
      emit(AddUserNameSuccess(userName: userName));
    } catch (e) {
      emit(AddUserNameFailure(error: e.toString()));
    }
  }
}
