part of 'reels_explore_cubit.dart';

sealed class ReelsExploreState extends Equatable {
  const ReelsExploreState();

  @override
  List<Object> get props => [];
}

final class ReelsExploreInitial extends ReelsExploreState {}

final class ReelsExploreLoading extends ReelsExploreState {}

final class ReelsExploreFailure extends ReelsExploreState {}

final class ReelsExploreSuccess extends ReelsExploreState {
  final List<PostEntity> reels;
  @override
  List<Object> get props => [reels];
  const ReelsExploreSuccess({required this.reels,});
}
