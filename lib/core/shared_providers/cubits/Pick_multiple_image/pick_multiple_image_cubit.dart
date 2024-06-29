import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/services/image_pick_services/image_picker.dart';

part 'pick_multiple_image_state.dart';

class PickMultipleImageCubit extends Cubit<PickMultipleImageState> {
  List<AssetEntity> images = [];
  PickMultipleImageCubit() : super(PickImageInitial());
  // void alreadySelectedImage(List<String> alredyAvailableImages) {
  //   emit(PickImageLoading());
  //   if (alredyAvailableImages.isEmpty) {
  //     return;
  //   }
  //   alreadyImages = alredyAvailableImages;
  // }

  Future<void> addImages(List<AssetEntity> assets) async {
    if (assets.isEmpty) {
      emit(PickImageInitial());
      return;
    }
    images.addAll(assets);
    emit(PickImageSuccess(images: images));
    print('addess sucess');
    // final imagess = await ImagePickerService.pickMultipleImages();
    // if (imagess.isNotEmpty) {
    //   images.addAll(imagess);
    //   emit(PickImageSuccess(images: images));
    // }
  }

  void clearImage() {
    images.clear();
    emit(PickImageSuccess(images: images));
  }

  void removeImage(int index) {
    emit(PickImageLoading());
    images.removeAt(index);
    if (images.isEmpty) {
      emit(PickImageInitial());
      return;
    }
    emit(PickImageSuccess(images: images));
  }

  @override
  Future<void> close() {
    emit(PickImageInitial());
    return super.close();
  }

  void clearState() {
    images.clear();
    emit(PickImageInitial());
  }
}
