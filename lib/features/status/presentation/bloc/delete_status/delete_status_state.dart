part of 'delete_status_bloc.dart';

sealed class DeleteStatusState extends Equatable {
  const DeleteStatusState();

  @override
  List<Object> get props => [];
}

final class DeleteStatusInitial extends DeleteStatusState {}

//states for deleting status
final class StatusDeleteLoading extends DeleteStatusState {}

final class StatusDeleteSuccess extends DeleteStatusState {}

final class StatusDeleteFailure extends DeleteStatusState {
  final String errorMsg;

  const StatusDeleteFailure({required this.errorMsg});
}
