import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/like_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/remove_like_comment.dart';

part 'like_comment_state.dart';

class LikeCommentCubit extends Cubit<LikeCommentState> {
  final LikeCommentUseCase _likeCommentUseCase;
  final RemoveLikeCommentUseCase _removeLikeCommentUseCase;
  LikeCommentCubit(this._likeCommentUseCase, this._removeLikeCommentUseCase)
      : super(CommentLikesInitial());

  Future<void> likeComment(
      {required String postId,
      required String commentId,
      required String currentUserId}) async {
    emit(CubitCommentLikesLoading());
    final res = await _likeCommentUseCase(LikeCommentUseCaseParams(
        currentUserId: currentUserId, postId: postId, commentId: commentId));
    res.fold((failure) => emit(CubitCommentLikesFailed(failure.message)),
        (success) => emit(CubitCommentLikesLoaded()));
  }

  Future<void> removeLikecomment(
      {required String postId,
      required String commentId,
      required String currentUserId}) async {
    emit(CubitCommentLikesLoading());
    final res = await _removeLikeCommentUseCase(RemoveLikeCommentUseCaseParams(
        currentUserId: currentUserId, postId: postId, commentId: commentId));
    res.fold((failure) => emit(CubitCommentLikesFailed(failure.message)),
        (success) => emit(CubitCommentLikesLoaded()));
  }
}
