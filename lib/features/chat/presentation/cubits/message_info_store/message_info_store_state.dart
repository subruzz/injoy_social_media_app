// part of 'message_info_store_cubit.dart';

// sealed class MessageInfoStoreState extends Equatable {
//   const MessageInfoStoreState();

//   @override
//   List<Object?> get props => [];
// }

// final class MessageInfoStoreInitial extends MessageInfoStoreState {}

// final class MessageInfoSet extends MessageInfoStoreState {}

// final class MessageInfoSetFailure extends MessageInfoStoreState {}

// final class MessageReplyClicked extends MessageInfoStoreState {
//   final bool isMe;
//   final String messageType;
//   final String? assetPath;
//   final String? caption;
//   final String userName;
//   final String repliedMessageCreator;
//   const MessageReplyClicked(
//       {required this.isMe,
//       required this.messageType,
//       required this.assetPath,
//       required this.userName,
//       required this.repliedMessageCreator,
//       required this.caption});
//   @override
//   List<Object?> get props => [isMe, messageType, caption, assetPath, userName];
// }

// final class MessageReplyRemoved extends MessageInfoStoreState {}

// final class UserStatusState extends MessageInfoStoreState {
//   final bool online;
//   @override
//   List<Object?> get props => [online];
//   const UserStatusState({required this.online});
// }
