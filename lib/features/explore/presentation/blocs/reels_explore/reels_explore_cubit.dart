import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';

part 'reels_explore_state.dart';

// Creating a separate cubit for fetching shorts.
// We are not reusing the same cubit as in the reels page
// because the shorts feature is part of the bottom bar navigation
// and requires preserving its state.

class ReelsExploreCubit extends Cubit<ReelsExploreState> {
  final GetReelsUseCase _getReelsUseCase;

  ReelsExploreCubit(this._getReelsUseCase) : super(ReelsExploreInitial());

  final List<PostEntity> _shorts = [];

  void init(PostEntity post) {
    _shorts.clear(); // Clear previous data if necessary
    _shorts.add(post);
    emit(ReelsExploreSuccess(reels: List.from(_shorts))); // Emit state with the list copy
  }

  void getReels(String myId, String? excludedId) async {
    final res = await _getReelsUseCase(
        GetReelsUseCaseParams(myId: myId, excludedId: excludedId));

    res.fold(
      (failure) {
        emit(ReelsExploreFailure());
      },
      (success) {
        _shorts.addAll(success.reels);
        log('Number of shorts: ${_shorts.length}');
        emit(ReelsExploreSuccess(reels: List.from(_shorts))); // Emit state with the list copy
      },
    );
  }
}
