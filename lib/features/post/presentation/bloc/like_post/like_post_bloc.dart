// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/post/domain/usecases/like_post.dart';

part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final LikePostsUseCase _likePostsUseCase;
  LikePostBloc(this._likePostsUseCase) : super(LikePostInitial()) {
    on<LikePostEvent>((event, emit) {
      emit(LikePostLoading());
    });
    on<LikePostClickEvent>(_likePost);
  }

  FutureOr<void> _likePost(
      LikePostClickEvent event, Emitter<LikePostState> emit) async {
    final res =
        await _likePostsUseCase(LikePostsUseCaseParams(postId: event.postId));
    res.fold((failure) => emit(LikePostLoading()),
        (success) => emit(const LikePostSuccess(likeCount: 4)));
  }
}
