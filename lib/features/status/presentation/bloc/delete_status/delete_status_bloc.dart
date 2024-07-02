import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/status/domain/usecases/delete_status.dart';

part 'delete_status_event.dart';
part 'delete_status_state.dart';

class DeleteStatusBloc extends Bloc<DeleteStatusEvent, DeleteStatusState> {
  final DeleteStatuseCase _deleteStatuseCase;

  DeleteStatusBloc({required DeleteStatuseCase deleteStatusUseCase})
      : _deleteStatuseCase = deleteStatusUseCase,
        super(DeleteStatusInitial()) {
    on<DeleteStatus>(_deleteStatusEvent);
  }
  FutureOr<void> _deleteStatusEvent(
      DeleteStatus event, Emitter<DeleteStatusState> emit) async {
    emit(StatusDeleteLoading());

    final res = await _deleteStatuseCase(
        DeleteStatusUseCaseParams(sId: event.sId, imgUrl: event.imgUrl));
    res.fold((failure) => emit(StatusDeleteFailure(errorMsg: failure.message)),
        (success) => emit(StatusDeleteSuccess()));
  }
}
