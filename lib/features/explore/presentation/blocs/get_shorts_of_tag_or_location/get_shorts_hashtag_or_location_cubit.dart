import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_shorts_of_tag_or_location.dart';

part 'get_shorts_hashtag_or_location_state.dart';

class GetShortsHashtagOrLocationCubit
    extends Cubit<GetShortsHashtagOrLocationState> {
  GetShortsHashtagOrLocationCubit(this._getShortsOfTags)
      : super(GetShortsHashtagPostsInitial());
  final GetShortsOfTagOrLocationUseCase _getShortsOfTags;

  void getShortsHashTagPosts(String hashtagOrLocation,
      [bool isloc = false]) async {
    emit(GetHashTagShortsPostLoading());

    final res = await _getShortsOfTags(GetShortsOfTagOrLocationUseCaseParams(
        tagOrLocation: hashtagOrLocation, isLoc: isloc));
    res.fold(
        (failure) =>
            emit(GetHashTagShortsPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagShortsPostSucess(hashTagShortsPosts: success));
    });
  }
}
