import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/usecases/post/save_post.dart';

part 'save_post_state.dart';

class SavePostCubit extends Cubit<SavePostState> {
  final SavePostUseCase _savePostUseCase;
  SavePostCubit(this._savePostUseCase) : super(SavePostInitial());

  void savePost({
    required String postId,
    required VoidCallback callBack,
  }) async {
    final res = await _savePostUseCase(SavePostUseCaseParams(postId: postId));
    res.fold((failure) {
      emit(SavePostFailure(error: failure.message));
      callBack();
    }, (success) {
      emit(SavePostSuccess());
    });
  }
}
