part of 'delete_status_bloc.dart';

sealed class DeleteStatusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class DeleteStatus extends DeleteStatusEvent {
  final String sId;
  final String? imgUrl;
   DeleteStatus({
    this.imgUrl,
    required this.sId,
  });
}
