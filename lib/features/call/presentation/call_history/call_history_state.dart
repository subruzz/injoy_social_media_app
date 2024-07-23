part of 'call_history_cubit.dart';

sealed class CallHistoryState extends Equatable {
  const CallHistoryState();

  @override
  List<Object> get props => [];
}

final class CallHistoryInitial extends CallHistoryState {}
