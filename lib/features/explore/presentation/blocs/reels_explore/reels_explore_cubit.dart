import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';

part 'reels_explore_state.dart';

class ReelsExploreCubit extends Cubit<ReelsExploreState> {
  final GetReelsUseCase _getReelsUseCase;

  ReelsExploreCubit(this._getReelsUseCase, PostEntity post)
      : super(ReelsExploreState(reels: [post]));

  void init(PostEntity post) {
    emit(state.copyWith(reels: [post])); // Re-initialize the state with the new post
  }

  Future<void> getReels(String myId, String? excludedId) async {
    emit(state.copyWith(isLoading: true)); // Emit loading state

    final res = await _getReelsUseCase(
        GetReelsUseCaseParams(myId: myId, excludedId: excludedId));

    res.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isError: true)); // Emit failure state
      },
      (success) {
        final updatedReels = List<PostEntity>.from(state.reels)..addAll(success.reels);
        log('Number of reels: ${updatedReels.length}');
        emit(state.copyWith(isLoading: false, reels: updatedReels)); // Emit success state with updated reels
      },
    );
  }
}
