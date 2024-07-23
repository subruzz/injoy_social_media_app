import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';
import 'package:social_media_app/features/call/domain/usecases/end_call.dart';
import 'package:social_media_app/features/call/domain/usecases/get_user_calling.dart';
import 'package:social_media_app/features/call/domain/usecases/make_call.dart';
import 'package:social_media_app/features/call/domain/usecases/save_call_history.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final GetUserCallingUseCase _getUserCallingUseCase;
  final MakeCallUseCase _makeCallUseCase;
  final EndCallUseCase _endCallUseCase;
  final SaveCallHistoryUseCase _saveCallHistoryUseCase;

  final MessageInfoStoreCubit _messageInfoStoreCubit;
  CallCubit({
    required GetUserCallingUseCase getUserCallingUseCase,
    required MakeCallUseCase makeCallUseCase,
    required MessageInfoStoreCubit messageStroreCubit,
    required EndCallUseCase endCallUseCase,
    required SaveCallHistoryUseCase saveCallHistoryUseCase,
  })  : _getUserCallingUseCase = getUserCallingUseCase,
        _makeCallUseCase = makeCallUseCase,
        _endCallUseCase = endCallUseCase,
        _messageInfoStoreCubit = messageStroreCubit,
        _saveCallHistoryUseCase = saveCallHistoryUseCase,
        super(CallInitial());

  Future<void> getUserCalling(String uId) async {
    final streamRes = _getUserCallingUseCase.call(uId);
    await for (var value in streamRes) {
      value.fold((failure) => emit(CallFailed()), (success) {
        emit(CallDialed(userCall: success.isEmpty ? null : success.first));
      });
    }
  }

  Future<void> makeCall(CallEntity call) async {
    emit(IsCalling());
    final res = await _makeCallUseCase(MakeCallUseCaseParams(call: call));
    res.fold((failure) => emit(CallFailed()), (success) {});
  }

  Future<void> endCall() async {
    emit(IsCalling());
    final res = await _endCallUseCase(EndCallUseCaseParams(
        callerId: _messageInfoStoreCubit.senderId,
        recieverId: _messageInfoStoreCubit.receiverId));
    res.fold((failure) => emit(CallFailed()), (success) {});
  }

  Future<void> saveCallHistory(CallEntity call) async {
    emit(IsCalling());
    final res =
        await _saveCallHistoryUseCase(SaveCallHistoryUseCaseParams(call: call));
    res.fold((failure) => emit(CallFailed()), (success) {});
  }
}
