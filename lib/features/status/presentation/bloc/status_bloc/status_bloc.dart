// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/utils/other/id_generator.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/status/domain/usecases/create_multiple_status.dart';

import 'package:social_media_app/features/status/domain/usecases/create_status.dart';
import 'package:social_media_app/features/status/domain/usecases/delete_status.dart';
import 'package:social_media_app/features/status/domain/usecases/seeen_status_update.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final CreateStatusUseCase _createStatusUseCase;
  final SeeenStatusUpdateUseCase _seeenStatusUpdateUseCase;
  final CreateMultipleStatusUseCase _createMultipleStatusUseCase;
  StatusBloc({
    required CreateStatusUseCase createStatusUseCase,
    required DeleteStatuseCase deleteStatuseCase,
    required SeeenStatusUpdateUseCase seeenStatusUpdateUseCase,
    required CreateMultipleStatusUseCase createMultipleStatusUseCase,
  })  : _createStatusUseCase = createStatusUseCase,
        _seeenStatusUpdateUseCase = seeenStatusUpdateUseCase,
        _createMultipleStatusUseCase = createMultipleStatusUseCase,
        super(StatusInitial()) {
    on<CreateStatusEvent>(_createStatus);
    on<SeenStatusUpateEvent>(_seeenStatusUpdate);
    on<CreateMultipleStatusEvent>(_createMultipleStatuses);
  }

  FutureOr<void> _createStatus(
      CreateStatusEvent event, Emitter<StatusState> emit) async {
    emit(StatusCreateLoading());

    if (event.content!.isEmpty) {
      emit(const StatusCreateFailure(
          errorMsg: AppErrorMessages.statusEmptyContent, detailError: ''));
      return;
    }

    final currentTime = Timestamp.now();
    final newStatus = SingleStatusEntity(
        uId: event.userId,
        statusId: IdGenerator.generateUniqueId(),
        createdAt: currentTime,
        content: event.content,
        color: event.color,
        viewers: {});
    final res = await _createStatusUseCase(CreateStatusUseCaseParams(
      singleStatus: newStatus,
    ));
    res.fold(
        (failure) => emit(StatusCreateFailure(
            errorMsg: failure.message, detailError: failure.details)),
        (success) => emit(StatusCreateSuccess()));
  }

  FutureOr<void> _seeenStatusUpdate(
      SeenStatusUpateEvent event, Emitter<StatusState> emit) async {
    final res = await _seeenStatusUpdateUseCase(SeeenStatusUpdateUseCaseParams(
      statusId: event.statusId,
      viewedUid: event.viewedUid,
    ));
    res.fold((failure) => emit(StatusSeenUpdateFailure()),
        (success) => emit(StatusSeenUpdateSuccess()));
  }

  FutureOr<void> _createMultipleStatuses(
      CreateMultipleStatusEvent event, Emitter<StatusState> emit) async {
    emit(StatusCreateLoading());
    //just to make sure nothing goes wrong
    final lengthofCaption = event.captions.length;
    final List<SingleStatusEntity> statuses = [];
    for (int i = 0; i < event.statusImages.length; i++) {
      final newS = SingleStatusEntity(
          uId: event.userId,
          content: i < lengthofCaption ? event.captions[i] : null,
          statusId: IdGenerator.generateUniqueId(),
          createdAt: Timestamp.now(),
          isThatVdo: event.statusImages[i].mediaType == MediaType.video,
          viewers: {});
      statuses.add(newS);
    }

    final res = await _createMultipleStatusUseCase(
        CreateMutlipleStatusUseCaseParams(
            statuses: statuses, assets: event.statusImages));
    res.fold(
        (failure) => emit(StatusCreateFailure(
            errorMsg: failure.message, detailError: failure.details)),
        (success) => emit(StatusCreateSuccess()));
  }
}
