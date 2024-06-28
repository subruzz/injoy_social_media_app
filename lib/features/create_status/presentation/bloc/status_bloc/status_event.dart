part of 'status_bloc.dart';

sealed class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

final class CreateStatusEvent extends StatusEvent {
  final String userId;
  final String userName;
  final String? profilePic;
  final String? content;
  final int color;
  final File? statusImage;
  const CreateStatusEvent(
      {required this.userId,
      this.profilePic,
      required this.userName,
      required this.content,
      required this.color,
      required this.statusImage});
}

final class DeleteStatusEvent extends StatusEvent {
  final String sId;
  final String uId;

  const DeleteStatusEvent({required this.sId, required this.uId});
}

final class SeenStatusUpateEvent extends StatusEvent {
  final String uId;
  final int index;
  final String viewedUid;

  const SeenStatusUpateEvent(
      {required this.uId, required this.index, required this.viewedUid});
}
