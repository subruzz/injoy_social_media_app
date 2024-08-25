part of 'get_shorts_hashtag_or_location_cubit.dart';

sealed class GetShortsHashtagOrLocationState extends Equatable {
  const GetShortsHashtagOrLocationState();

  @override
  List<Object> get props => [];
}

final class GetShortsHashtagPostsInitial
    extends GetShortsHashtagOrLocationState {}

final class GetHashTagShortsPostLoading
    extends GetShortsHashtagOrLocationState {}

final class GetHashTagShortsPostFailure
    extends GetShortsHashtagOrLocationState {
  final String erroMsg;

  const GetHashTagShortsPostFailure({required this.erroMsg});
}

final class GetHashTagShortsPostSucess extends GetShortsHashtagOrLocationState {
  final List<PostEntity> hashTagShortsPosts;

  const GetHashTagShortsPostSucess({required this.hashTagShortsPosts});
}
