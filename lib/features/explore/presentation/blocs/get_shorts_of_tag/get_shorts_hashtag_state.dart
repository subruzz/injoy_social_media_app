part of 'get_shorts_hashtag_cubit.dart';

sealed class GetShortsHashtagState extends Equatable {
  const GetShortsHashtagState();

  @override
  List<Object> get props => [];
}

final class GetRecentHashtagPostsInitial extends GetShortsHashtagState {}

final class GetHashTagRecentPostLoading extends GetShortsHashtagState {}

final class GetHashTagRecentPostFailure extends GetShortsHashtagState {
  final String erroMsg;

  const GetHashTagRecentPostFailure({required this.erroMsg});
}

final class GetHashTagRecentPostSucess extends GetShortsHashtagState {
  final List<PostEntity> hashTagRecentPosts;

  const GetHashTagRecentPostSucess({required this.hashTagRecentPosts});
}
