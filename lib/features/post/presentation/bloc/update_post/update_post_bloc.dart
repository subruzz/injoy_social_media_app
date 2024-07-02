import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';
import 'package:social_media_app/features/post/domain/usecases/update_post.dart';

part 'update_post_event.dart';
part 'update_post_state.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  final UpdatePostsUseCase _updatePostsUseCase;
  UpdatePostBloc(this._updatePostsUseCase) : super(UpdatePostInitial()) {
    on<UpdatePostEvent>((event, emit) {
      emit(UpdatePostLoading());
    });
    on<UpdatePost>(_updatePost);
  }

  FutureOr<void> _updatePost(
      UpdatePost event, Emitter<UpdatePostState> emit) async {
    final updatedPost = UpdatePostEntity(
      hashtags: event.hashtags,
      description: event.description,
    );
    final res = await _updatePostsUseCase(
        UpdatePostsUseCaseParams(post: updatedPost, postId: event.postId));
    res.fold((failure) => emit(UpdatePostsError(errorMsg: failure.message)),
        (success) => emit(UpdatePostSuccess(updatePost: success)));
  }
}
