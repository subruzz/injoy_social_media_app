import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';

import '../../../../../../core/utils/errors/failure.dart';
import '../../../../../../core/common/functions/firebase_helper.dart';
import '../../../../../../core/utils/di/di.dart';
import '../../../../domain/usecases/get_single_user_message_usecase.dart';

part 'get_message_state.dart';

class GetMessageCubit extends Cubit<GetMessageState> {
  final GetSingleUserMessageUsecase _getSingleUserMessageUsecase;
  StreamSubscription<Either<Failure, List<MessageEntity>>>?
      _messageSubscription;
  StreamSubscription<AppUser>? _userSubscription;
  StreamSubscription<bool?>? _blockChatStream;

  bool _loadchat = true;

  GetMessageCubit(this._getSingleUserMessageUsecase)
      : super(const GetMessageInitial());

  Future<void> setRecipientMessageUserDetails(
      String userId, String otherUserId) async {
    try {
      emit(state.copyWith(loading: true, otherUser: null, errorMessage: null));

      final userDetailsStream =
          serviceLocator<FirebaseHelper>().getUserDetailsStream(otherUserId);

      _userSubscription = userDetailsStream.listen(
        (appUserModel) {
          if (_loadchat) {
            getPersonalChats(senderId: userId, recipientId: otherUserId);
          }
          final userStatus = UserStatusInfo(
              showOnline: appUserModel.showLastSeen,
              isOnline: appUserModel.onlineStatus,
              userPic: appUserModel.profilePic,
              userName: appUserModel.userName ?? '',
              lastSeen: appUserModel.lastSeen);
          emit(state.copyWith(
              loading: _loadchat,
              otherUser: appUserModel,
              errorMessage: null,
              statusInfo: userStatus));
          if (_loadchat) _loadchat = false;
        },
        onError: (error) {
          emit(state.copyWith(loading: false, errorMessage: 'User not found'));
        },
      );
      final blockChatStatus = serviceLocator<FirebaseHelper>()
          .getIsBlockedByMeStream(userId, otherUserId);
      _blockChatStream = blockChatStatus.listen((value) {
        log('value is $value');
        emit(state.copyWith(
            statusInfo: state.statusInfo?.copyWith(isBlockedByMe: value)));
      });
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: 'User not found'));
    }
  }

  Future<void> getPersonalChats({
    required String senderId,
    required String recipientId,
  }) async {
    emit(state.copyWith(
      loading: true,
    ));

    final streamRes = _getSingleUserMessageUsecase.call(senderId, recipientId);
    // Subscribe to the new stream
    _messageSubscription = streamRes.listen(
      (either) {
        either.fold(
          (failure) {
            emit(state.copyWith(loading: false, errorMessage: failure.message));
          },
          (messages) {
            log('camer here to get messages');

            emit(state.copyWith(
              loading: false,
              messages: messages,
              errorMessage: null,
            ));
            log('new state is $state');
          },
        );
      },
      onError: (error) {
        emit(state.copyWith(
          loading: false,
          errorMessage: error.toString(),
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _userSubscription?.cancel();
    _blockChatStream?.cancel();
    return super.close();
  }
}

class UserStatusInfo extends Equatable {
  final String userName;
  final bool isOnline;
  final bool showOnline;
  final Timestamp? lastSeen;
  final String? userPic;
  final bool? isBlockedByMe;

  const UserStatusInfo({
    required this.userName,
    this.userPic,
    this.isBlockedByMe,
    required this.showOnline,
    required this.isOnline,
    required this.lastSeen,
  });

  // CopyWith method
  UserStatusInfo copyWith({
    String? userName,
    bool? isOnline,
    bool? showOnline,
    Timestamp? lastSeen,
    String? userPic,
    bool? isBlockedByMe,
  }) {
    return UserStatusInfo(
      userName: userName ?? this.userName,
      isOnline: isOnline ?? this.isOnline,
      showOnline: showOnline ?? this.showOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      userPic: userPic ?? this.userPic,
      isBlockedByMe: isBlockedByMe ?? this.isBlockedByMe,
    );
  }

  @override
  List<Object?> get props => [
        showOnline,
        userName,
        userPic,
        isOnline,
        lastSeen,
        isBlockedByMe,
      ];
}
