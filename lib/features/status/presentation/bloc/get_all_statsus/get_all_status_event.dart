part of 'get_all_status_bloc.dart';

sealed class GetAllStatusEvent extends Equatable {
  const GetAllStatusEvent();

  @override
  List<Object> get props => [];
}

final class GetAllstatusesEvent extends GetAllStatusEvent {
  final String uId;

  const GetAllstatusesEvent({required this.uId});
}
