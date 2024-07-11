part of 'get_post_comment_cubit.dart';

sealed class GetPostCommentState extends Equatable {
  const GetPostCommentState();

  @override
  List<Object> get props => [];
}

final class GetPostCommentInitial extends GetPostCommentState {}

final class GetPostCommentLoading extends GetPostCommentState {}

final class GetPostCommentSuccess extends GetPostCommentState {
  final List<CommentEntity> postComments;

  const GetPostCommentSuccess({required this.postComments});
}

final class GetPostCommentFailure extends GetPostCommentState {
  final String erroMsg;

  const GetPostCommentFailure({required this.erroMsg});
}
