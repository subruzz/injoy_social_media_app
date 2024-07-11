part of 'get_recommended_post_cubit.dart';

sealed class GetRecommendedPostState extends Equatable {
  const GetRecommendedPostState();

  @override
  List<Object> get props => [];
}

final class GetRecommendedPostInitial extends GetRecommendedPostState {}

final class GetRecommendedPostLoading extends GetRecommendedPostState {}

final class GetRecommendedPostFailure extends GetRecommendedPostState {
  final String erroMsg;

  const GetRecommendedPostFailure({required this.erroMsg});
}

final class GetRecommendedPostSuccess extends GetRecommendedPostState {
  final List<PostEntity> recommendedPosts;

  const GetRecommendedPostSuccess({required this.recommendedPosts});
}
