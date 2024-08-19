part of 'status_viewers_cubit.dart';

sealed class StatusViewersState extends Equatable {
  const StatusViewersState();

  @override
  List<Object> get props => [];
}

final class StatusViewersInitial extends StatusViewersState {}

final class StatusViewersLoading extends StatusViewersState {}

final class StatusViewersError extends StatusViewersState {}

final class StatusViewersSuccess extends StatusViewersState {
  final List<(PartialUser, Timestamp)> statusViewers;

  const StatusViewersSuccess({required this.statusViewers});
}
