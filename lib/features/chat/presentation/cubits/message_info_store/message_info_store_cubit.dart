import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_info_store_state.dart';

class MessageInfoStoreCubit extends Cubit<MessageInfoStoreState> {
  MessageInfoStoreCubit({required String id})
      : _senderId = id,
        super(MessageInfoStoreInitial());

  final String _senderId;
  String _receiverId = '';
  String _receiverName = '';
  String? _receiverProfile;

  // Getters
  String get senderId => _senderId;
  String get receiverId => _receiverId;
  String get receiverName => _receiverName;
  String? get receiverProfile => _receiverProfile;

  void setDataForChat({
    required String? receiverProfile,
    required String receiverName,
    required String recipientId,
  }) {
    if (recipientId == receiverId) {
      return emit(MessageInfoSet());
    }
    _receiverProfile = receiverProfile;
    _receiverName = receiverName;
    _receiverId = recipientId;

    if (areDetailsComplete()) {
      emit(MessageInfoSet());
    } else {
      emit(MessageInfoSetFailure());
    }
  }

  void clearDetails() {
    _receiverId = '';
    _receiverName = '';
    _receiverProfile = null;
  }

  bool areDetailsComplete() {
    return _senderId.isNotEmpty &&
        _receiverId.isNotEmpty &&
        _receiverName.isNotEmpty;
  }
}
