import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_hashtag_top_posts.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_recent_posts_hashtag.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';

part 'get_hash_tag_posts_state.dart';

class GetHashTagPostsCubit extends Cubit<GetHashTagPostsState> {
  final GetHashtagTopPostsUseCase _getHashTagTopPostSucess;
  GetHashTagPostsCubit(
      this._getHashTagTopPostSucess,)
      : super(GetHashTagPostsInitial());
  void getTopHashTagPosts(String hashtag) async {
    emit(GetHashTagTopPostLoading());

    final res = await _getHashTagTopPostSucess(
        GetHashtagTopPostsUseCaseParams(tag: hashtag));
    res.fold(
        (failure) => emit(GetHashTagTopPostFailure(erroMsg: failure.message)),
        (success) {
      emit(GetHashTagTopPostSucess(hashTagTopPosts: success));
    });
  }


}
