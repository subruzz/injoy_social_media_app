import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/read_comment.dart';

import '../../../../domain/enitities/comment_entity.dart';

part 'get_post_comment_state.dart';

class GetPostCommentCubit extends Cubit<GetPostCommentState> {
  final ReadCommentUseCase _readCommentUseCase;
  StreamSubscription? _streamSubscription; // Add a subscription field

  GetPostCommentCubit(this._readCommentUseCase)
      : super(GetPostCommentInitial());

  Future<void> getPostComments({
    required String postId,
    required Function(num commentCount) oncommentAction,
  }) async {
    emit(GetPostCommentLoading());

    // Subscribe to the stream
    _streamSubscription = _readCommentUseCase.call(postId).listen((value) {
      value.fold(
        (failure) => emit(GetPostCommentFailure(erroMsg: failure.message)),
        (success) {
          oncommentAction(success.length);
          emit(GetPostCommentSuccess(postComments: success));
        },
      );
    });
  }

  @override
  Future<void> close() {
    // Ensure the stream subscription is canceled
    _streamSubscription?.cancel();
    log('get comment cubit closed');

    return super.close();
  }
}
