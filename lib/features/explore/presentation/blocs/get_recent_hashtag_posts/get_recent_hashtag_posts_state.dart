part of 'get_recent_hashtag_posts_cubit.dart';

sealed class GetRecentHashtagPostsState extends Equatable {
  const GetRecentHashtagPostsState();

  @override
  List<Object> get props => [];
}

final class GetRecentHashtagPostsInitial extends GetRecentHashtagPostsState {}

final class GetHashTagRecentPostLoading extends GetRecentHashtagPostsState {}

final class GetHashTagRecentPostFailure extends GetRecentHashtagPostsState {
  final String erroMsg;

  const GetHashTagRecentPostFailure({required this.erroMsg});
}

final class GetHashTagRecentPostSucess extends GetRecentHashtagPostsState {
  final List<PostEntity> hashTagRecentPosts;

  const GetHashTagRecentPostSucess({required this.hashTagRecentPosts});
}
