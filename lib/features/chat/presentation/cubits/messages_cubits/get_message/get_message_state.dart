part of 'get_message_cubit.dart';

class GetMessageState extends Equatable {
  const GetMessageState({
    required this.loading,
    required this.messages,
    this.errorMessage,
    this.otherUser,
    this.statusInfo,
  });

  final List<MessageEntity> messages;
  final String? errorMessage;
  final AppUser? otherUser;
  final bool loading;
  final UserStatusInfo? statusInfo;

  @override
  List<Object?> get props =>
      [messages, errorMessage, otherUser, loading, statusInfo];

  GetMessageState copyWith({
    List<MessageEntity>? messages,
    String? errorMessage,
    AppUser? otherUser,
    bool? loading,
    UserStatusInfo? statusInfo,
  }) {
    return GetMessageState(
      loading: loading ?? this.loading,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      otherUser: otherUser ?? this.otherUser,
      statusInfo: statusInfo ?? this.statusInfo,
    );
  }
}

final class GetMessageInitial extends GetMessageState {
  const GetMessageInitial()
      : super(
          messages: const [],
          errorMessage: null,
          otherUser: null,
          loading: false,
        );
}
