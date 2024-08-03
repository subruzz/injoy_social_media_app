part of 'explore_user_cubit.dart';

sealed class ExploreAllPostsState extends Equatable {
  const ExploreAllPostsState();

  @override
  List<Object> get props => [];
}

final class ExploreUserInitial extends ExploreAllPostsState {}

class ExplorePostsLoading extends ExploreAllPostsState {}

class ExploreAllPostsLoaded extends ExploreAllPostsState {
  final List<PostEntity> allPosts;

  const ExploreAllPostsLoaded({
    required this.allPosts,
  });
  @override
  List<Object> get props => [];
}

class ExplorePostsError extends ExploreAllPostsState {
  final String message;

  const ExplorePostsError(this.message);
}
