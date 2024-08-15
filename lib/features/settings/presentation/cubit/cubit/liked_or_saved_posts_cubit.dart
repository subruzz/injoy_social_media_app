import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/settings/domain/usecases/get_liked_posts.dart';
import 'package:social_media_app/features/settings/domain/usecases/get_saved_posts.dart';

part 'liked_or_saved_posts_state.dart';

class LikedOrSavedPostsCubit extends Cubit<LikedOrSavedPostsState> {
  final GetSavedPostsUseCase _getLikedOrSavedPostsUseCase;
  final GetLikedPostsUseCase _getLikedPostsUseCase;
  LikedOrSavedPostsCubit(
      this._getLikedOrSavedPostsUseCase, this._getLikedPostsUseCase)
      : super(LikedOrSavedPostsInitial());

  void getSavedPosts(List<String> savedPostIds) async {
    emit(LikedOrSavedPostsLoading());
    final res = await _getLikedOrSavedPostsUseCase(
        GetSavedPostsUseCaseParams(savedPostIds: savedPostIds));

    res.fold((failure) => emit(LikedOrSavedPostsFailure()),
        (sucess) => emit(LikedOrSavedPostsSuccess(likedOrSavedPosts: sucess)));
  }

  void getLikedPosts(String myId) async {
    emit(LikedOrSavedPostsLoading());

    final res =
        await _getLikedPostsUseCase(GetLikedPostsUseCaseParams(myId: myId));

    res.fold((failure) => emit(LikedOrSavedPostsFailure()),
        (sucess) => emit(LikedOrSavedPostsSuccess(likedOrSavedPosts: sucess)));
  }
}
