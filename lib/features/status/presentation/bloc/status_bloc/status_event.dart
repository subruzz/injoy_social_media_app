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


final class SeenStatusUpateEvent extends StatusEvent {
  final String statusId;
  final String viewedUid;

  const SeenStatusUpateEvent({required this.statusId, required this.viewedUid});
}

final class CreateMultipleStatusEvent extends StatusEvent {
  final String userId;
  final String userName;
  final String? profilePic;
  final List<String> captions;
  final List<SelectedByte> statusImages;
  const CreateMultipleStatusEvent(
      {required this.userId,
      this.profilePic,
      required this.userName,
      required this.captions,
      required this.statusImages});
}
