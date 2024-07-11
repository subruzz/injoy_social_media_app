import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/read_comment.dart';

part 'get_post_comment_state.dart';

class GetPostCommentCubit extends Cubit<GetPostCommentState> {
  final ReadCommentUseCase _readCommentUseCase;
  GetPostCommentCubit(this._readCommentUseCase)
      : super(GetPostCommentInitial());

  FutureOr<void> getPostComments({required String postId}) async {
    final streamRes = _readCommentUseCase.call(postId);
    await for (var value in streamRes) {
      emit(GetPostCommentLoading());
      log('lisetning for post change from cubit');
      value.fold(
          (failure) => emit(GetPostCommentFailure(erroMsg: failure.message)),
          (success) => emit(GetPostCommentSuccess(postComments: success)));
    }
  }
}
