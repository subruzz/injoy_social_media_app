part of 'like_post_bloc.dart';

sealed class LikePostState extends Equatable {
  const LikePostState();

  @override
  List<Object> get props => [];
}

final class LikePostInitial extends LikePostState {}

final class LikePostLoading extends LikePostState {}

final class LikePostFailure extends LikePostState {}

final class LikePostSuccess extends LikePostState {
  final int likeCount;

  const LikePostSuccess({required this.likeCount});

}
