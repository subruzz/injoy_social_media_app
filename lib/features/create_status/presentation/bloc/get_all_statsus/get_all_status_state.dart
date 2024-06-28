part of 'get_all_status_bloc.dart';

sealed class GetAllStatusState extends Equatable {
  const GetAllStatusState();

  @override
  List<Object> get props => [];
}


class GetAllStatusInitial extends GetAllStatusState {}

class GetAllStatusLoading extends GetAllStatusState {}

class GetAllStatusSuccess extends GetAllStatusState {
final List<StatusEntity> allStatus;
  @override
  List<Object> get props => [allStatus];
  const GetAllStatusSuccess({required this.allStatus});
}

class GetAllStatusFailure extends GetAllStatusState {}
