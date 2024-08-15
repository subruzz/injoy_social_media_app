part of 'reels_explore_cubit.dart';

class ReelsExploreState extends Equatable {
  final List<PostEntity> reels;
  final bool isLoading;
  final bool isError;

  const ReelsExploreState({
    this.reels = const [],
    this.isLoading = false,
    this.isError = false,
  });

  @override
  List<Object> get props => [reels, isLoading, isError];

  ReelsExploreState copyWith({
    List<PostEntity>? reels,
    bool? isLoading,
    bool? isError,
  }) {
    return ReelsExploreState(
      reels: reels ?? this.reels,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
