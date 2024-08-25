part of 'get_tag_or_location_posts_cubit.dart';

sealed class GetTagOrLocaationPostsState extends Equatable {
  const GetTagOrLocaationPostsState();

  @override
  List<Object> get props => [];
}

final class GetHashTagPostsInitial extends GetTagOrLocaationPostsState {}

final class GetHashTagTopPostLoading extends GetTagOrLocaationPostsState {}

final class GetHashTagTopPostFailure extends GetTagOrLocaationPostsState {
  final String erroMsg;

  const GetHashTagTopPostFailure({required this.erroMsg});
}

final class GetHashTagTopPostSucess extends GetTagOrLocaationPostsState {
  final List<PostEntity> hashTagTopPosts;

  const GetHashTagTopPostSucess({required this.hashTagTopPosts});
}

