part of 'for_you_post_bloc.dart';

sealed class ForYouPostState extends Equatable {
  const ForYouPostState();

  @override
  List<Object> get props => [];
}

final class ForYouPostInitial extends ForYouPostState {}

final class ForYouPostFeedLoading extends ForYouPostState {}

final class ForYouPostFeedError extends ForYouPostState {
  final String errorMsg;

  const ForYouPostFeedError({required this.errorMsg});
}

final class ForYouPostFeedSuccess extends ForYouPostState {
  final List<PostEntity> forYouPosts;

  const ForYouPostFeedSuccess({
    required this.forYouPosts,
  });
}
