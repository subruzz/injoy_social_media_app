// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/status_user_entity.dart';

import 'package:social_media_app/features/create_status/domain/usecases/create_status.dart';
import 'package:uuid/uuid.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final CreateStatusUseCase _createStatusUseCase;
  StatusBloc(
    this._createStatusUseCase,
  ) : super(StatusInitial()) {
    on<StatusEvent>((event, emit) {
      emit(StatusCreateLoading());
    });
    on<CreateStatusEvent>(_createStatus);
  }

  FutureOr<void> _createStatus(
      CreateStatusEvent event, Emitter<StatusState> emit) async {
    final currentTime = Timestamp.now();
    final newPost = StatusEntity(
        sId: const Uuid().v4(),
        content: event.content,
        timestamp: currentTime,
        color: event.color,
        viewers: []);
    final statusUser = StatusUserAttribute(
        uid: event.userId,
        username: event.userName,
        profilePictureUrl: event.profilePic,
        lastCreated: currentTime);
    final res = await _createStatusUseCase(CreateStatusUseCaseParams(
        status: newPost,
        statusUserAttributes: statusUser,
        statusImage: event.statusImage));
    res.fold((failure) => emit(StatusCreateFailure(errorMsg: failure.message)),
        (success) => emit(StatusCreateSuccess()));
  }
}
