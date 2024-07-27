import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_reply_entity.dart';

part 'message_info_store_state.dart';

class MessageInfoStoreCubit extends Cubit<MessageInfoStoreState> {
  MessageInfoStoreCubit({required String id})
      : _senderId = id,
        super(MessageInfoStoreInitial());
  StreamSubscription<DocumentSnapshot>? _userStatusSubscription;
  List<String> _token = [];
  final String _senderId;
  String _receiverId = '';
  String _receiverName = '';
  String? _receiverProfile;

  // Getters
  List<String> get token => _token;
  String get senderId => _senderId;
  String get receiverId => _receiverId;
  String get receiverName => _receiverName;
  String? get receiverProfile => _receiverProfile;
  set setMessageReply(MessageEntity reply) {
    _messageReply = _messageReply;
  }

  MessageReplyEntity _messageReply = MessageReplyEntity();
  MessageReplyEntity get getMessageReply => _messageReply;
  void setDataForChat({
    required String? receiverProfile,
    required String receiverName,
    required String recipientId,
  }) {
    if (recipientId == receiverId) {
      return emit(MessageInfoSet());
    }
    // _userOnlineStatus(recipientId);
    _receiverProfile = receiverProfile;
    _receiverName = receiverName;
    _receiverId = recipientId;
    _token = [
      'eEiJrGBeSVGqgbc4FCDSvQ:APA91bE8sEjf9GZpsXn7BokCWVJGT8OFLcxIAdMs4Vi7KOOCOFIvuf-BXIZOvEvKlq3HtA0u0xO8MxpsCxs3foj2FlOSMrN2yZD1x2wzlDYQQ7RM6qKEmCKoRD2UmTVSZYDJfOu0rGfS'
    ];

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

  void replyClicked(
      {required bool isMe,
      required String messageType,
      String? assetPath,
      String? caption}) {
    emit(MessageReplyClicked(
        userName: isMe ? 'You' : _receiverName,
        isMe: isMe,
        messageType: messageType,
        assetPath: assetPath,
        caption: caption));
  }

  void replyRemoved() {
    emit(MessageReplyRemoved());
  }
}
