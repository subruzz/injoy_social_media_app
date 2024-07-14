part of 'get_hash_tag_posts_cubit.dart';

sealed class GetHashTagPostsState extends Equatable {
  const GetHashTagPostsState();

  @override
  List<Object> get props => [];
}

final class GetHashTagPostsInitial extends GetHashTagPostsState {}

final class GetHashTagTopPostLoading extends GetHashTagPostsState {}

final class GetHashTagTopPostFailure extends GetHashTagPostsState {
  final String erroMsg;

  const GetHashTagTopPostFailure({required this.erroMsg});
}

final class GetHashTagTopPostSucess extends GetHashTagPostsState {
  final List<PostEntity> hashTagTopPosts;

  const GetHashTagTopPostSucess({required this.hashTagTopPosts});
}

