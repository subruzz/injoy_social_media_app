import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_post/domain/usecases/get_assets.dart';

part 'asset_bloc_event.dart';
part 'asset_bloc_state.dart';

class AssetBlocBloc extends Bloc<AssetBlocEvent, AssetBlocState> {
  final LoadAssetsUseCase _loadAssetsUseCase;
  AssetBlocBloc(this._loadAssetsUseCase) : super(AssetBlocInitial()) {
    on<AssetBlocEvent>((event, emit) {
      emit(AssetLoading());
    });
    on<GetAssetsEvent>((event, emit) async {
      final res = await _loadAssetsUseCase(NoParams());
      res.fold(
        (failure) => emit(AssetFailure(
            error: failure.message, errorDetails: failure.details)),
        (success) => emit(
          AssetSuccess(assets: success),
        ),
      );
    });
  }
}
