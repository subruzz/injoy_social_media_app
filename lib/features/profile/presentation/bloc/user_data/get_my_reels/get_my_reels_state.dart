part of 'get_my_reels_cubit.dart';

sealed class GetMyReelsState extends Equatable {
  const GetMyReelsState();

  @override
  List<Object> get props => [];
}

final class GetMyReelsInitial extends GetMyReelsState {}

final class GetUserShortsLoading extends GetMyReelsState {}

final class GetUserShortsError extends GetMyReelsState {}

final class GetUserShortsSuccess extends GetMyReelsState {
  final List<PostEntity> myShorts;

  const GetUserShortsSuccess({
    required this.myShorts,
  });
  @override
  List<Object> get props => [myShorts];
}
