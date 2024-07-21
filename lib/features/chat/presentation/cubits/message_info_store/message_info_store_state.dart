part of 'message_info_store_cubit.dart';

sealed class MessageInfoStoreState extends Equatable {
  const MessageInfoStoreState();

  @override
  List<Object> get props => [];
}

final class MessageInfoStoreInitial extends MessageInfoStoreState {}

final class MessageInfoSet extends MessageInfoStoreState {}

final class MessageInfoSetFailure extends MessageInfoStoreState {}
