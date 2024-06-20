part of 'status_bloc.dart';

sealed class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

final class CreateStatusEvent extends StatusEvent {
  final String userId;
  final String userName;
  final String? content;
  final int color;
  final File? statusImage;

  const CreateStatusEvent(
      {required this.userId,
      required this.userName,
      required this.content,
      required this.color,
      required this.statusImage});
}
