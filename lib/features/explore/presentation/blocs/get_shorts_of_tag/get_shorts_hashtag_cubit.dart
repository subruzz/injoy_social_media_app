import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_shorts_of_tag.dart';

part 'get_shorts_hashtag_state.dart';

class GetShortsHashtagCubit extends Cubit<GetShortsHashtagState> {
  GetShortsHashtagCubit(this._getRecentPostsHashtagUseCase)
      : super(GetRecentHashtagPostsInitial());
  final GetShortsOfTagUseCase _getRecentPostsHashtagUseCase;

  void getRecentHashTagPosts(String hashtag) async {
    emit(GetHashTagRecentPostLoading());

    final res = await _getRecentPostsHashtagUseCase(
        GetShortsOfTagUseCaseParams(tag: hashtag));
    res.fold(
        (failure) =>
            emit(GetHashTagRecentPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagRecentPostSucess(hashTagRecentPosts: success));
    });
  }
}
