import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/firebase_helper.dart';
import '../../../../../../init_dependecies.dart';
import '../../../../domain/usecases/get_single_user_message_usecase.dart';

part 'get_message_state.dart';

class GetMessageCubit extends Cubit<GetMessageState> {
  final GetSingleUserMessageUsecase _getSingleUserMessageUsecase;
  StreamSubscription<Either<Failure, List<MessageEntity>>>?
      _messageSubscription;
  StreamSubscription<AppUser>? _userSubscription;
  bool _loadchat = true;

  GetMessageCubit(this._getSingleUserMessageUsecase)
      : super(const GetMessageInitial());

  Future<void> setRecipientMessageUserDetails(
      String userId, String otherUserId) async {
    try {
      emit(state.copyWith(loading: true, otherUser: null, errorMessage: null));

      final userDetailsStream =
          serviceLocator<FirebaseHelper>().getUserDetailsStream(otherUserId);

      // Listen to the stream
      _userSubscription = userDetailsStream.listen(
        (appUserModel) {
          if (_loadchat) {
            _loadchat = false;
            getPersonalChats(senderId: userId, recipientId: otherUserId);
          }
          final userStatus = UserStatusInfo(
              isOnline: appUserModel.onlineStatus,
              userName: appUserModel.userName ?? '',
              lastSeen: appUserModel.lastSeen);
          emit(state.copyWith(
              loading: false,
              otherUser: appUserModel,
              errorMessage: null,
              statusInfo: userStatus));
        },
        onError: (error) {
          emit(state.copyWith(loading: false, errorMessage: 'User not found'));
        },
      );
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
      messages: [],
      errorMessage: null,
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
            emit(state.copyWith(
              loading: false,
              messages: messages,
              errorMessage: null,
            ));
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
    return super.close();
  }
}

class UserStatusInfo extends Equatable {
  final String userName;

  final bool isOnline;

  final Timestamp? lastSeen;

  const UserStatusInfo(
      {required this.userName, required this.isOnline, required this.lastSeen});
  @override
  List<Object?> get props => [userName, isOnline, lastSeen];
}
