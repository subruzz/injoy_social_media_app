import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_recent_posts_hashtag.dart';

part 'get_recent_hashtag_posts_state.dart';

class GetRecentHashtagPostsCubit extends Cubit<GetRecentHashtagPostsState> {
  GetRecentHashtagPostsCubit(this._getRecentPostsHashtagUseCase)
      : super(GetRecentHashtagPostsInitial());
  final GetRecentPostsHashtagUseCase _getRecentPostsHashtagUseCase;

  void getRecentHashTagPosts(String hashtag) async {
    emit(GetHashTagRecentPostLoading());

    final res = await _getRecentPostsHashtagUseCase(
        GetRecentPostsHashtagUseCaseParams(tag: hashtag));
    res.fold(
        (failure) =>
            emit(GetHashTagRecentPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagRecentPostSucess(hashTagRecentPosts: success));
    });
  }
}
