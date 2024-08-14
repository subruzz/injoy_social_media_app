part of 'suggestion_from_post_cubit.dart';

class SuggestionFromPostState extends Equatable {
  final List<PostEntity> posts;
  final bool isLoading;
  final bool hasError;

  // Constructor for the initial state
  const SuggestionFromPostState({
    this.posts = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  SuggestionFromPostState copyWith({
    List<PostEntity>? posts,
    bool? isLoading,
    bool? hasError,
  }) {
    return SuggestionFromPostState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [posts, isLoading, hasError];
}
