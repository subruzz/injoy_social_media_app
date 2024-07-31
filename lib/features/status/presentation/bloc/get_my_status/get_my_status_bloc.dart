import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_my_status.dart';

part 'get_my_status_event.dart';
part 'get_my_status_state.dart';

class GetMyStatusBloc extends Bloc<GetMyStatusEvent, GetMyStatusState> {
  final GetMyStatusUseCase _getMyStatusUseCase;
  GetMyStatusBloc({required GetMyStatusUseCase getMyStatusUseCase})
      : _getMyStatusUseCase = getMyStatusUseCase,
        super(GetMyStatusInitial()) {
    on<GetAllMystatusesEvent>(_getMystatuses);
  }

  FutureOr<void> _getMystatuses(
      GetAllMystatusesEvent event, Emitter<GetMyStatusState> emit) async {
    try {
      log('this called');

      final streamRes = _getMyStatusUseCase.call(event.uId);
      await for (var value in streamRes) {
        emit(GetMyStatusSuccess(myStatus: value));
      }
    } on SocketException {
      emit(GetMyStatusFailure());
    } catch (e) {
      emit(GetMyStatusFailure());
    }
  }
}
