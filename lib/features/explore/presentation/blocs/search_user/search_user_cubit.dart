import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_user.dart';

part 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  final SearchUserUseCase _searchUserUseCase;
  SearchUserCubit(this._searchUserUseCase) : super(SearchUserInitial());
  Future<void> searchUser(String query) async {
    if (query.isEmpty) {
      emit(SearchUserInitial());
      return;
    }
    emit(SearchUserLoading());
    final res = await _searchUserUseCase(SearchUserUseCaseParams(query: query));
    res.fold((failure) => emit(SearchUserFailure(erroMsg: failure.message)),
        (success) {
        
      log('searched users are here $success');
      emit(SearchUserSuccess(searchedUsers: success, query: query));
    });
  }
}
