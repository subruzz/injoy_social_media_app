// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

import 'package:social_media_app/features/create_status/domain/usecases/create_status.dart';
import 'package:social_media_app/features/create_status/domain/usecases/delete_status.dart';
import 'package:social_media_app/features/create_status/domain/usecases/seeen_status_update.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:uuid/uuid.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final CreateStatusUseCase _createStatusUseCase;
  final DeleteStatuseCase _deleteStatuseCase;
  final SeeenStatusUpdateUseCase _seeenStatusUpdateUseCase;

  StatusBloc(
    this._createStatusUseCase,
    this._deleteStatuseCase,
    this._seeenStatusUpdateUseCase,
  ) : super(StatusInitial()) {
    on<StatusEvent>((event, emit) {
      emit(StatusCreateLoading());
    });
    on<CreateStatusEvent>(_createStatus);
    on<DeleteStatusEvent>(_deleteStatusEvent);
    on<SeenStatusUpateEvent>(_seeenStatusUpdate);
  }

  FutureOr<void> _createStatus(
      CreateStatusEvent event, Emitter<StatusState> emit) async {
    final currentTime = Timestamp.now();
    final newStatus = SingleStatusEntity(
        statusId: const Uuid().v4(),
        timestamp: currentTime,
        content: event.content,
        color: event.color,
        viewers: []);
    final userEntity = StatusEntity(
      statuses: [newStatus],
      uId: event.userId,
      userName: event.userName,
      lastCreated: currentTime,
      profilePic: event.profilePic,
    );
    final res = await _createStatusUseCase(
        CreateStatusUseCaseParams(singleStatus: newStatus, status: userEntity));
    res.fold((failure) => emit(StatusCreateFailure(errorMsg: failure.message)),
        (success) => emit(StatusCreateSuccess()));
  }

  FutureOr<void> _deleteStatusEvent(
      DeleteStatusEvent event, Emitter<StatusState> emit) async {
    final res = await _deleteStatuseCase(
        DeleteStatusUseCaseParams(sId: event.sId, uId: event.uId));
    res.fold((failure) => emit(StatusDeleteFailure(errorMsg: failure.message)),
        (success) => emit(StatusDeleteSuccess()));
  }

  FutureOr<void> _seeenStatusUpdate(
      SeenStatusUpateEvent event, Emitter<StatusState> emit) async {
    final res = await _seeenStatusUpdateUseCase(SeeenStatusUpdateUseCaseParams(
        uId: event.uId, viewedUid: event.viewedUid,  index: event.index));
    res.fold((failure) => emit(StatusSeenUpdateFailure()),
        (success) => emit(StatusSeenUpdateSuccess()));
  }
}
