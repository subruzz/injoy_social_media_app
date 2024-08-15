part of 'get_shorts_hashtag_cubit.dart';

sealed class GetShortsHashtagState extends Equatable {
  const GetShortsHashtagState();

  @override
  List<Object> get props => [];
}

final class GetShortsHashtagPostsInitial extends GetShortsHashtagState {}

final class GetHashTagShortsPostLoading extends GetShortsHashtagState {}

final class GetHashTagShortsPostFailure extends GetShortsHashtagState {
  final String erroMsg;

  const GetHashTagShortsPostFailure({required this.erroMsg});
}

final class GetHashTagShortsPostSucess extends GetShortsHashtagState {
  final List<PostEntity> hashTagShortsPosts;

  const GetHashTagShortsPostSucess({required this.hashTagShortsPosts});
}
