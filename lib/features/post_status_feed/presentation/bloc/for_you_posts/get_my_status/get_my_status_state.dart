part of 'get_my_status_bloc.dart';

sealed class GetMyStatusState extends Equatable {
  const GetMyStatusState();
  @override
  List<Object> get props => [];
}

class GetMyStatusInitial extends GetMyStatusState {}

class GetMyStatusLoading extends GetMyStatusState {}

class GetMyStatusSuccess extends GetMyStatusState {
  final List<SingleStatusEntity> myStatus;
  @override
  List<Object> get props => [myStatus];
  const GetMyStatusSuccess({required this.myStatus});
}

class GetMyStatusFailure extends GetMyStatusState {}
