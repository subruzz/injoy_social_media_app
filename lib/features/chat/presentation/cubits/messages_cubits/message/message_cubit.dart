import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:record/record.dart';
import 'package:social_media_app/core/common/chat_utils.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/id_generator.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/seen_message_update_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:social_media_app/features/chat/presentation/cubits/messages_cubits/get_message/get_message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

import '../../../../domain/entities/message_reply_entity.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final AppUserBloc _appUserBloc;
  final SendMessageUseCase _sendMessageUseCase;
  final DeleteMessageUsecase _deleteMessageUsecase;
  final SeenMessageUpdateUsecase _seenMessageUpdateUsecase;
  Timer? _timer;
  int _elapsedSeconds = 0;
  final _audioRecorder = AudioRecorder();
  set setMessageReply(MessageEntity reply) {
    _messageReply = _messageReply;
  }

  MessageReplyEntity _messageReply = MessageReplyEntity();
  MessageReplyEntity get getMessageReply => _messageReply;
  MessageCubit(this._sendMessageUseCase, this._deleteMessageUsecase,
      this._seenMessageUpdateUsecase, this._appUserBloc)
      : super(MessageInitial());
  void replyClicked(
      {required bool isMe,
      required String messageType,
      String? assetPath,
      required String repliedMessagecreator,
      String? caption}) {
    emit(MessageReplyClicked(
        userName: _appUserBloc.appUser.userName ?? '',
        repliedToMe: isMe,
        repliedMessageCreator: repliedMessagecreator,
        messageType: messageType,
        assetPath: assetPath,
        caption: caption));
  }

  void initialState() {
    emit(MessageInitial());
  }

  Future<void> sendMessage({
    required String recentTextMessage,
    required String? messageType,
    List<SelectedByte>? selectedAssets,
    List<String>? captions,
    required GetMessageState messageState,
  }) async {
    if (messageState.otherUser == null) {
      log('null');
      return;
    }
    final otherUser = messageState.otherUser!;
    final MessageReplyClicked? replyState =
        state is MessageReplyClicked ? state as MessageReplyClicked : null;

    final newChat = ChatEntity(
        senderName: _appUserBloc.appUser.userName,
        senderProfile: _appUserBloc.appUser.profilePic,
        senderUid: _appUserBloc.appUser.id,
        recipientUid: otherUser.id,
        recipientName: otherUser.userName,
        recentTextMessage: '',
        recipientProfile: otherUser.profilePic,
        totalUnReadMessages: 0,
        createdAt: Timestamp.now());
    List<MessageEntity> multipleMessages = [];
    MessageEntity? newMessge;
    if (selectedAssets != null &&
        captions != null &&
        selectedAssets.isNotEmpty &&
        selectedAssets.length == captions.length) {
      for (int assets = 0; assets < selectedAssets.length; assets++) {
        log('correct${selectedAssets[assets]}');
        final newMessage = MessageEntity(
            isDeleted: false,
            createdAt: null,
            repliedMessgeCreatorId: replyState?.repliedMessageCreator,
            repliedMessage: replyState?.caption,
            repliedMessageAssetLink: replyState?.assetPath,
            repliedMessageType: replyState?.messageType,
            repliedTo: replyState?.userName,
            message: captions[assets],
            isEdited: false,
            deletedAt: null,
            assetPath: selectedAssets[assets],
            senderUid: _appUserBloc.appUser.id,
            recipientUid: otherUser.id,
            messageType: selectedAssets[assets].mediaType == MediaType.photo
                ? MessageTypeConst.photoMessage
                : MessageTypeConst.videoMessage,
            isSeen: false,
            messageId: IdGenerator.generateUniqueId());
        multipleMessages.add(newMessage);
      }
    } else {
      newMessge = MessageEntity(
          isDeleted: false,
          repliedMessgeCreatorId: replyState?.repliedMessageCreator,
          createdAt: null,
          message: recentTextMessage,
          isEdited: false,
          deletedAt: null,
          repliedMessage: replyState?.caption,
          repliedMessageAssetLink: replyState?.assetPath,
          repliedMessageType: replyState?.messageType,
          repliedTo: replyState?.userName,
          senderUid: _appUserBloc.appUser.id,
          recipientUid: otherUser.id,
          messageType: messageType ?? MessageTypeConst.textMessage,
          isSeen: false,
          messageId: IdGenerator.generateUniqueId());
    }
    // await PushNotificiationServices.sendNotificationToUser('');
    final res = await _sendMessageUseCase(SendMessageUseCaseParams(
        chat: newChat,
        message: selectedAssets != null ? multipleMessages : [newMessge!]));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
    initialState();
  }

  // void deleteMessage({required String messageId}) async {
  //   final res = await _deleteMessageUsecase(DeleteMessageUsecaseParams(
  //       sendorId: _messageInfoStoreCubit.senderId,
  //       recieverId: _messageInfoStoreCubit.receiverId,
  //       messageId: messageId));
  //   res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
  //       (success) {});
  // }

  void voiceRecordingStarted() async {
    emit(VoiceMessageStarted());

    await initAudioRecord(audioRecorder: _audioRecorder);
    _elapsedSeconds = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
      voiceRecordingOngoing();
    });
  }

  void voiceRecordingOngoing() {
    emit(VoiceMessageOngoing(durration: _elapsedSeconds));
  }

  void voiceRecordStopped(GetMessageState messageState) async {
    _timer?.cancel();
    String? audioPath = await _audioRecorder.stop();
    if (audioPath == null || messageState.otherUser == null) {
      return emit(
          const MessageFailure(errorMsg: 'Error sending voice message'));
    }

    final otherUser = messageState.otherUser!;
    initialState();

    log('called');
    final newChat = ChatEntity(
        senderName: _appUserBloc.appUser.userName,
        senderProfile: _appUserBloc.appUser.profilePic,
        senderUid: _appUserBloc.appUser.id,
        recipientUid: otherUser.id,
        recipientName: otherUser.userName,
        recentTextMessage: '',
        recipientProfile: otherUser.profilePic,
        totalUnReadMessages: 0,
        createdAt: Timestamp.now());
    final file = File(audioPath);
    final fileData = await File(audioPath).readAsBytes();

    final newMessage = MessageEntity(
      isDeleted: false,
      createdAt: null,
      message: '',
      isEdited: false,
      assetPath: SelectedByte(
        mediaType: MediaType.audio,
        selectedByte: fileData,
        selectedFile: file,
      ),
      deletedAt: null,
      senderUid: _appUserBloc.appUser.id,
      recipientUid: otherUser.id,
      messageType: MessageTypeConst.audioMessage,
      isSeen: false,
      messageId: IdGenerator.generateUniqueId(),
    );
    final res = await _sendMessageUseCase(
        SendMessageUseCaseParams(chat: newChat, message: [newMessage]));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
  }

  // void seeMessage({required String messageId}) async {
  //   final res = await _seenMessageUpdateUsecase(SeenMessageUpdateUsecaseParams(
  //       sendorId: _messageInfoStoreCubit.senderId,
  //       recieverId: _messageInfoStoreCubit.receiverId,
  //       messageId: messageId));
  //   res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
  //       (success) {});
  // }
}
