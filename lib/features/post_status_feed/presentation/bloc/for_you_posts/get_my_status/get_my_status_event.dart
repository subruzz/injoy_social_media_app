part of 'get_my_status_bloc.dart';

sealed class GetMyStatusEvent extends Equatable {
  const GetMyStatusEvent();

  @override
  List<Object> get props => [];
}

final class GetAllMystatusesEvent extends GetMyStatusEvent {
  final String uId;

  const GetAllMystatusesEvent({required this.uId});
}
