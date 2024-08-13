import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_shorts.dart';

import '../../../../../../core/common/entities/post.dart';
import '../../../../../../core/common/models/partial_user_model.dart';

part 'get_other_user_shorts_state.dart';

class GetOtherUserShortsCubit extends Cubit<GetOtherUserShortsState> {
  final GetUserShortsUseCase _getUserShortsUseCase;
  GetOtherUserShortsCubit(this._getUserShortsUseCase)
      : super(GetOtherUserShortsInitial());

  void getOtherUserShorts(PartialUser user) async {
    emit(GetOtherUserShortsLoading());
    final res =
        await _getUserShortsUseCase(GetUserShortsUseCaseParams(user: user));
    res.fold((failure) => emit(GetOtherUserShortsError()),
        (success) => emit(GetOtherUserShortsSuccess(myShorts: success)));
  }
}
