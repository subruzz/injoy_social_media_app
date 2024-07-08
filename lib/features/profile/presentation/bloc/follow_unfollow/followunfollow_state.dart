part of 'followunfollow_cubit.dart';

sealed class FollowunfollowState extends Equatable {
  const FollowunfollowState();

  @override
  List<Object> get props => [];
}

final class FollowunfollowInitial extends FollowunfollowState {}

final class FollowUnfollowLoading extends FollowunfollowState {}

final class FollowUnfollowFailure extends FollowunfollowState {
  final String errorMsg;

  const FollowUnfollowFailure({required this.errorMsg});
}

final class FollowSucess extends FollowunfollowState {}
final class UnfollowSucess extends FollowunfollowState {}
