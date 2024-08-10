import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';

part 'reels_state.dart';

class ReelsCubit extends Cubit<ReelsState> {
  final GetReelsUseCase _getReelsUseCase;
  ReelsCubit(this._getReelsUseCase) : super(ReelsInitial());
  void getReels(String myId) async {
    final res = await _getReelsUseCase(GetReelsUseCaseParams(myId: myId));
    res.fold((failure) => emit(ReelsFailure()),
        (success) => emit(ReelsSuccess(reels: success)));
  }
}
