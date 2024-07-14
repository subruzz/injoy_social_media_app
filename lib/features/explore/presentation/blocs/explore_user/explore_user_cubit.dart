import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_suggested_users.dart';

import '../../../../../core/common/models/partial_user_model.dart';

part 'explore_user_state.dart';

class ExploreUserCubit extends Cubit<ExploreUserState> {
  final GetSuggestedUsersUseCase _getSuggestedUsersUseCase;
  ExploreUserCubit(this._getSuggestedUsersUseCase)
      : super(ExploreUserInitial());
  Future<void> getSuggestedUsers(
      {required String myId, required List<String> interests}) async {
    emit(ExploreUsersLoading());

    final res = await _getSuggestedUsersUseCase(
        GetSuggestedUsersUseCaseParams(myId: myId, interests: interests));

    res.fold((failure) => emit(ExploreUsersError(failure.message)),
        (success) => emit(ExploreUsersLoaded(suggestedUsers: success)));
  }
}
