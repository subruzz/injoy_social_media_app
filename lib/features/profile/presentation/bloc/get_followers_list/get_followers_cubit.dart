import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_followers_list.dart';

part 'get_followers_state.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  final GetFollowersListUseCase _getFollowersListUseCase;
  GetFollowersCubit(this._getFollowersListUseCase)
      : super(GetFollowersInitial());
  void getMyFollowersList({required String myId}) async {
    emit(FollowersListLoading());
    final res = await _getFollowersListUseCase(
        GetFollowersListUseCaseParms(myUid: myId));
    res.fold((failure) => emit(FollowersListError(failure.message)),
        (success) => emit(FollowersListLoaded(success)));
  }
}
