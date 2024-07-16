part of 'comment_basic_cubit.dart';

sealed class CommentBasicState extends Equatable {
  const CommentBasicState();

  @override
  List<Object> get props => [];
}

final class CommentBasicInitial extends CommentBasicState {}

class CommentLoading extends CommentBasicState {}

class CommentError extends CommentBasicState {
  final String error;

  const CommentError({required this.error});
}

class CommentSuccess extends CommentBasicState {}

class CommentAddedSuccess extends CommentBasicState {}

class CommentDeletedSuccess extends CommentBasicState {}
