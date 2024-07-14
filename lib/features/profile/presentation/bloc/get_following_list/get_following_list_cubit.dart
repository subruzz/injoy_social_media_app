import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_following_list.dart';

part 'get_following_list_state.dart';

class GetFollowingListCubit extends Cubit<GetFollowingListState> {
  final GetFollowingListUseCase _followingListUseCase;
  GetFollowingListCubit(this._followingListUseCase)
      : super(GetFollowingListInitial());

  void getMyFollowingList(
      {required String myId, required List<String> following}) async {
    emit(FollowingListLoading());
    final res = await _followingListUseCase(
        GetFollowingListUseCaseParms(following: following, myUid: myId));

    res.fold((failure) => emit(FollowingListError(failure.message)),
        (success) => emit(FollowingListLoaded(success)));
  }
}
