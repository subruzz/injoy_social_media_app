import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_single_user_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final SendMessageUseCase _sendMessageUseCase;
  final GetSingleUserMessageUsecase _getSingleUserMessageUsecase;
  MessageCubit(this._sendMessageUseCase, this._getSingleUserMessageUsecase)
      : super(MessageInitial());
  Future<void> getMyChats({required MessageEntity msg}) async {
    final streamRes = _getSingleUserMessageUsecase.call(msg);
    await for (var value in streamRes) {
      emit(MessageLoading());
      value.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
          (success) => emit(MessageLoaded(messages: success)));
    }
  }

  Future<void> sendMessage(
      {required MessageEntity msg, required ChatEntity chat}) async {
    emit(MessageLoading());
    final res = await _sendMessageUseCase(
        SendMessageUseCaseParams(chat: chat, message: msg));
    res.fold((failure) => emit(MessageFailure(errorMsg: failure.message)),
        (success) {});
  }
}
