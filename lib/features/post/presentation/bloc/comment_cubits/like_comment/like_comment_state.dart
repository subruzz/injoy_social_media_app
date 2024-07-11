part of 'like_comment_cubit.dart';

sealed class LikeCommentState extends Equatable {
  const LikeCommentState();

  @override
  List<Object> get props => [];
}



class CommentLikesInitial extends LikeCommentState {}

class CubitCommentLikesLoading extends LikeCommentState {}

class CubitCommentLikesLoaded extends LikeCommentState {}

class CubitCommentLikesFailed extends LikeCommentState {
  final String error;
  const CubitCommentLikesFailed(this.error);
}
