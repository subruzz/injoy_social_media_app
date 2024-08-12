import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';

part 'reels_state.dart';

class ReelsCubit extends Cubit<ReelsState> {
  DocumentSnapshot? _lastDocument;

  final GetReelsUseCase _getReelsUseCase;

  ReelsCubit(this._getReelsUseCase) : super(ReelsInitial());

  void getReels(String myId, {bool isInitialLoad = true}) async {
    try {
      final res = await _getReelsUseCase(
          GetReelsUseCaseParams(myId: myId, lastDoc: _lastDocument));

      res.fold(
        (failure) {
          log('Error fetching reels: $failure');
          emit(ReelsFailure());
        },
        (success) {
          _lastDocument = success.lastDocument;
          log('last doc in cubit is  $_lastDocument');
          final reels = success.reels;

          log('Fetched ${reels.length} reels. Last document: ${_lastDocument?.id}');

          if (isInitialLoad) {
            emit(ReelsSuccess(reels: reels, lastDocument: _lastDocument));
          } else {
            final currentState = state;
            if (currentState is ReelsSuccess) {
              emit(ReelsSuccess(
                  reels: [...currentState.reels, ...reels],
                  lastDocument: _lastDocument));
            }
          }
        },
      );
    } catch (e) {
      log('Exception occurred: $e');
      emit(ReelsFailure());
    }
  }
}
