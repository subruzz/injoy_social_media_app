import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_nearyby_users.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_suggested_users.dart';

import '../../../../../core/common/models/partial_user_model.dart';

part 'explore_user_state.dart';

class ExploreUserCubit extends Cubit<ExploreUserState> {
  final GetSuggestedUsersUseCase _getSuggestedUsersUseCase;
  final GetNearybyUsersUseCase _getNearybyUsersUseCase;
  ExploreUserCubit(this._getSuggestedUsersUseCase, this._getNearybyUsersUseCase)
      : super(ExploreUserInitial());
  Future<void> getSuggestedUsers(
      {required String myId, required List<String> interests}) async {
    emit(ExploreUsersLoading());

    final res = await _getSuggestedUsersUseCase(
        GetSuggestedUsersUseCaseParams(myId: myId, interests: interests));

    res.fold((failure) => emit(ExploreUsersError(failure.message)),
        (success) => emit(ExploreUsersLoaded(suggestedUsers: success)));
  }

  Future<void> getNearByUses(
      {required String myId,
      required double? latitude,
      required double? longitude}) async {
    if (longitude == null || latitude == null) {
      return;
    }
    emit(ExploreUsersLoading());

    final res = await _getNearybyUsersUseCase(GetNearybyUsersUseCaseParams(
        myId: myId, latitude: latitude, longitude: longitude));

    res.fold((failure) => emit(ExploreUsersError(failure.message)),
        (success) => emit(ExploreUsersLoaded(suggestedUsers: success)));
  }
}
