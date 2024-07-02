part of 'status_bloc.dart';

sealed class StatusState extends Equatable {
  const StatusState();

  @override
  List<Object> get props => [];
}

//states for creating status
final class StatusInitial extends StatusState {}

final class StatusCreateSuccess extends StatusState {}

final class StatusCreateFailure extends StatusState {
  final String errorMsg;
  final String detailError;

  const StatusCreateFailure({
    required this.errorMsg,
    required this.detailError,
  });
}

final class StatusCreateLoading extends StatusState {}



//states for updating status
final class StatusSeenUpdateSuccess extends StatusState {}

final class StatusSeenUpdateFailure extends StatusState {}
