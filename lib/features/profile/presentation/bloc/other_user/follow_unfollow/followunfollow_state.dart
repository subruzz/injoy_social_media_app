part of 'followunfollow_cubit.dart';

sealed class FollowunfollowState extends Equatable {
  const FollowunfollowState();

  @override
  List<Object> get props => [];
}

final class FollowunfollowInitial extends FollowunfollowState {}

final class FollowLoading extends FollowunfollowState {}

final class UnfollowLoading extends FollowunfollowState {}

final class FollowFailure extends FollowunfollowState {
  final String errorMsg;

  const FollowFailure({required this.errorMsg});
}

final class FollowUnfollowStarted extends FollowunfollowState {}

final class UnfollowFailure extends FollowunfollowState {
  final String errorMsg;

  const UnfollowFailure({required this.errorMsg});
}

final class FollowSuccess extends FollowunfollowState {}

final class UnfollowSuccess extends FollowunfollowState {}
