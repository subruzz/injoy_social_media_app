part of 'get_other_user_shorts_cubit.dart';

sealed class GetOtherUserShortsState extends Equatable {
  const GetOtherUserShortsState();

  @override
  List<Object> get props => [];
}

final class GetOtherUserShortsInitial extends GetOtherUserShortsState {}

final class GetOtherUserShortsLoading extends GetOtherUserShortsState {}

final class GetOtherUserShortsError extends GetOtherUserShortsState {}

final class GetOtherUserShortsSuccess extends GetOtherUserShortsState {
  final List<PostEntity> myShorts;

  const GetOtherUserShortsSuccess({
    required this.myShorts,
  });
}
