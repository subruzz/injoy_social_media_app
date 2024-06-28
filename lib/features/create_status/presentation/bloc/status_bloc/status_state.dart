part of 'status_bloc.dart';

sealed class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

final class StatusInitial extends StatusState {}

final class StatusCreateSuccess extends StatusState {}

final class StatusCreateFailure extends StatusState {
  final String errorMsg;

  const StatusCreateFailure({required this.errorMsg});
}

final class StatusCreateLoading extends StatusState {}

//states for deleting status
final class StatusDeleteLoading extends StatusState {}

final class StatusDeleteSuccess extends StatusState {}

final class StatusDeleteFailure extends StatusState {
  final String errorMsg;

  const StatusDeleteFailure({required this.errorMsg});
}

final class StatusSeenUpdateSuccess extends StatusState {}

final class StatusSeenUpdateFailure extends StatusState {}
