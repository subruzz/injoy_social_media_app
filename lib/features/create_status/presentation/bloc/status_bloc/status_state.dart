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
