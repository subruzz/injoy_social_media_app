import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_shorts_of_tag.dart';

part 'get_shorts_hashtag_state.dart';

class GetShortsHashtagCubit extends Cubit<GetShortsHashtagState> {
  GetShortsHashtagCubit(this._getShortsOfTags)
      : super(GetShortsHashtagPostsInitial());
  final GetShortsOfTagUseCase _getShortsOfTags;

  void getShortsHashTagPosts(String hashtag) async {
    emit(GetHashTagShortsPostLoading());

    final res =
        await _getShortsOfTags(GetShortsOfTagUseCaseParams(tag: hashtag));
    res.fold(
        (failure) =>
            emit(GetHashTagShortsPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagShortsPostSucess(hashTagShortsPosts: success));
    });
  }
}
