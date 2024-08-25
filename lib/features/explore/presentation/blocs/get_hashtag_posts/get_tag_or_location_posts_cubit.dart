import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_hashtag_or_location_posts.dart';

part 'get_tag_or_locaation_posts_state.dart';

class GetTagOrLocationPostsCubit extends Cubit<GetTagOrLocaationPostsState> {
  final GetHashtagOrLocationPostsUseCase _getHashTagTopPostSucess;
  GetTagOrLocationPostsCubit(
    this._getHashTagTopPostSucess,
  ) : super(GetHashTagPostsInitial());
  void getTagOrLocationPosts(String hashTagOrLocation,
      [bool isLoc = false]) async {
    emit(GetHashTagTopPostLoading());
    final res = await _getHashTagTopPostSucess(
        GetHashtagOrLocationPostsUseCaseParams(
            tagOrLocation: hashTagOrLocation, isLoc: isLoc));
    res.fold(
        (failure) => emit(GetHashTagTopPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagTopPostSucess(hashTagTopPosts: success));
    });
  }
}
