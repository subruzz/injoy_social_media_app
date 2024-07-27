import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/usecases/add_visited_user.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/usecases/get_all_visited_user.dart';

part 'who_visited_event.dart';
part 'who_visited_state.dart';

class WhoVisitedBloc extends Bloc<WhoVisitedEvent, WhoVisitedState> {
  final AddVisitedUserUseCase _addVisitedUserUseCase;
  final GetAllVisitedUserUseCase _getAllVisitedUser;
  WhoVisitedBloc(this._addVisitedUserUseCase, this._getAllVisitedUser)
      : super(WhoVisitedInitial()) {
    on<WhoVisitedEvent>((event, emit) {});
    on<GetAllVisitedUser>(_getallVisitiedUsers);
    on<AddUserToVisited>(_addUserToVisited);
  }

  FutureOr<void> _getallVisitiedUsers(
      GetAllVisitedUser event, Emitter<WhoVisitedState> emit) async {
    final res = await _getAllVisitedUser(
        GetAllVisitedUserUseCaseParams(myId: event.myId));
    res.fold((failure) => emit(GetVisitedUserError(error: failure.message)),
        (success) => emit(GetVisitedUserSuccess(visitedUsers: success)));
  }

  FutureOr<void> _addUserToVisited(
      AddUserToVisited event, Emitter<WhoVisitedState> emit) async {
    await _addVisitedUserUseCase(AddVisitedUserUseCaseParams(
        myId: event.myId, visitedUserId: event.visitedUserId));
    // res.fold((failure) => emit(GetVisitedUserError(error: failure.message)),
    //     (success) => emit(GetVisitedUserSuccess(visitedUsers: success)));
  }
}
