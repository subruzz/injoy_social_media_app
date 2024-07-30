import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/features/assets/domain/usecase/get_assets.dart';

part 'assets_event.dart';
part 'assets_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final LoadAssetsUseCase _loadAssetsUseCase;
  AssetsBloc(this._loadAssetsUseCase) : super(AssetsInitial()) {
    on<AssetsEvent>((event, emit) {
      emit(AssetLoading());
    });
    on<GetAssetsEvent>(_getAssets);
  }

  FutureOr<void> _getAssets(
      GetAssetsEvent event, Emitter<AssetsState> emit) async {
    final res = await _loadAssetsUseCase(
        LoadAssetsUseCaseParams(selectedAlbum: event.selectedAlbum));
    res.fold(
        (failure) => emit(AssetFailure(
            error: failure.message, errorDetails: failure.details)),
        (success) => emit(AssetSuccess(assets: success)));
  }
}
