// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/usecases/like_post.dart';
import 'package:social_media_app/features/post/domain/usecases/unlike_post.dart';

part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final LikePostsUseCase _likePostsUseCase;
  final UnlikePostsUseCase _unlikePostsUseCase;
  LikePostBloc(this._likePostsUseCase, this._unlikePostsUseCase)
      : super(LikePostInitial()) {
    on<LikePostEvent>((event, emit) {
      emit(LikePostLoading());
    });
    on<LikePostClickEvent>(_likePost);
    on<UnlikePostClickEvent>(_unlikePost);
  }

  FutureOr<void> _likePost(
      LikePostClickEvent event, Emitter<LikePostState> emit) async {
    final res = await _likePostsUseCase(LikePostsUseCaseParams(
        postId: event.postId, currentUserId: event.currentUserId));
    res.fold((failure) => emit(LikePostLoading()),
        (success) => emit(LikePostSuccess()));
  }

  FutureOr<void> _unlikePost(
      UnlikePostClickEvent event, Emitter<LikePostState> emit) async {
    final res = await _unlikePostsUseCase(UnlikePostsUseCaseParams(
        postId: event.postId, currentUserId: event.currentUserId));
    res.fold((failure) => emit(LikePostLoading()),
        (success) => emit(LikePostSuccess()));
  }
}
