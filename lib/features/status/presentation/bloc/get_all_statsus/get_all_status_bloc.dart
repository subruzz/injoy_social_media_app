import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_all_statuses.dart';

part 'get_all_status_event.dart';
part 'get_all_status_state.dart';

class GetAllStatusBloc extends Bloc<GetAllStatusEvent, GetAllStatusState> {
  final GetAllStatusesUseCase _allStatusesUseCase;
  GetAllStatusBloc({required GetAllStatusesUseCase getAllStatusesUseCase})
      : _allStatusesUseCase = getAllStatusesUseCase,
        super(GetAllStatusInitial()) {
    on<GetAllStatusEvent>((event, emit) {
      emit(GetAllStatusLoading());
    });
    on<GetAllstatusesEvent>(_getAllStatus);
  }

  FutureOr<void> _getAllStatus(
      GetAllstatusesEvent event, Emitter<GetAllStatusState> emit) async {
    try {
      final streamRes = _allStatusesUseCase.call(event.uId);
      await for (var value in streamRes) {
     
        emit(GetAllStatusSuccess(allStatus: value));
      }
    } on SocketException {
      emit(GetAllStatusFailure());
    } catch (e) {
      emit(GetAllStatusFailure());
    }
  }
}
