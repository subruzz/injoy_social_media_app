import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_shorts.dart';

import '../../../../../core/common/entities/post.dart';
import '../../../../../core/common/models/partial_user_model.dart';

part 'get_my_reels_state.dart';

class GetMyReelsCubit extends Cubit<GetMyReelsState> {
  final GetUserShortsUseCase _getUserShortsUseCase;
  GetMyReelsCubit(this._getUserShortsUseCase) : super(GetMyReelsInitial());

  void getMyReels(PartialUser user) async {
    emit(GetUserShortsLoading());
    final res =
        await _getUserShortsUseCase(GetUserShortsUseCaseParams(user: user));
    res.fold((failure) => emit(GetUserShortsError()),
        (success) => emit(GetUserShortsSuccess(myShorts: success)));
  }
}
