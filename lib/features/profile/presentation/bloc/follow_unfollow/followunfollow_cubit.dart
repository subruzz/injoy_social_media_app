import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/follow_user.dart';
import 'package:social_media_app/features/profile/domain/usecases/unfollow_user.dart';

part 'followunfollow_state.dart';

class FollowunfollowCubit extends Cubit<FollowunfollowState> {
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;
  FollowunfollowCubit(this._followUserUseCase, this._unfollowUserUseCase)
      : super(FollowunfollowInitial());

  void followUser({required String myId, required String otherId}) async {
    emit(FollowUnfollowLoading());
    final res = await _followUserUseCase(
        FollowUserUseCaseParms(otherUserUid: otherId, myUid: myId));
    res.fold(
        (failure) => emit(FollowUnfollowFailure(errorMsg: failure.message)),
        (success) => emit(FollowSucess()));
  }

  void unfollowUser({required String myId, required String otherId}) async {
    emit(FollowUnfollowLoading());
    final res = await _unfollowUserUseCase(
        UnfollowUserUseCaseParms(otherUserUid: otherId, myUid: myId));
    res.fold(
        (failure) => emit(FollowUnfollowFailure(errorMsg: failure.message)),
        (success) => emit(UnfollowSucess()));
  }
}
