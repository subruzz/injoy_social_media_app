import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/usecases/get_my_status.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/get_my_status/get_my_status_bloc.dart';


class GetMyStatusBloc extends Bloc<GetMyStatusEvent, GetMyStatusState> {
  final GetMyStatusUseCase _getMyStatusUseCase;
  GetMyStatusBloc(this._getMyStatusUseCase, )
      : super(GetMyStatusInitial()) {
    on<GetAllMystatusesEvent>(_getMystatuses);
  }

  FutureOr<void> _getMystatuses(
      GetAllMystatusesEvent event, Emitter<GetMyStatusState> emit) async {
    emit(GetMyStatusLoading());

    try {
      final streamRes = _getMyStatusUseCase.call(event.uId);
      await for (var value in streamRes) {
        print('enfdgdfgdftered here');
        print('gotfgh the value');
        print(value.allStatuses.length);
        emit(GetMyStatusSuccess(myStatus: value));
      }
    } on SocketException {
      emit(GetMyStatusFailure());
    } catch (e) {
      emit(GetMyStatusFailure());
    }
  }

 
}
