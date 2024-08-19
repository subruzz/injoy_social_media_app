import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_status_viewers.dart';

import '../../../../../core/common/models/partial_user_model.dart';

part 'status_viewers_state.dart';

class StatusViewersCubit extends Cubit<StatusViewersState> {
  final GetStatusViewersUseCase _getStatusViewersUseCase;
  StatusViewersCubit(this._getStatusViewersUseCase)
      : super(StatusViewersInitial());
  void setInit() {
    emit(StatusViewersInitial());
  }

  void getStatusViewers(Map<String, Timestamp> viewersMap) async {
    emit(StatusViewersLoading());
    final res = await _getStatusViewersUseCase(
        GetStatusViewersUseCaseParams(viewersMap: viewersMap));
    res.fold((failure) => emit(StatusViewersError()),
        (success) => emit(StatusViewersSuccess(statusViewers: success)));
  }
}
