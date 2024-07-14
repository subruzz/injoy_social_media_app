import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_recommended_post.dart';

part 'get_recommended_post_state.dart';

class GetRecommendedPostCubit extends Cubit<GetRecommendedPostState> {
  final GetRecommendedPostUseCase _getRecommendedPostUseCase;
  GetRecommendedPostCubit(this._getRecommendedPostUseCase)
      : super(GetRecommendedPostInitial());
  Future<void> getRecommendedPosts(String query) async {
    emit(GetRecommendedPostLoading());
    final res = await _getRecommendedPostUseCase(
        GetRecommendedPostUseCaseParams(query: query));
    res.fold(
        (failure) => emit(GetRecommendedPostFailure(erroMsg: failure.message)),
        (success) {
      log('recommeneded posts are $success');
      emit(GetRecommendedPostSuccess(recommendedPosts: success, query: query));
    });
  }
}
