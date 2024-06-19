import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/services/image_pick_services/image_picker.dart';

part 'pick_multiple_image_state.dart';

class PickMultipleImageCubit extends Cubit<PickMultipleImageState> {
  List<File?> images = [];

  PickMultipleImageCubit() : super(PickImageInitial()); 

  Future<void> pickImage() async {
    try {
      emit(PickImageLoading());
      final imagess = await ImagePickerService.pickMultipleImages();
      if (imagess.isNotEmpty) {
        images = imagess;
        emit(PickImageSuccess(images: images));
      } else {
        emit(PickImageFailure('No image selected'));
      }
    } catch (e) {
      emit(PickImageFailure(e.toString()));
    }
  }

  void removeImage(File? img) {
    emit(PickImageLoading());
    images.remove(img);
    if (images.isEmpty) {
      emit(PickImageInitial());
      return;
    }
    emit(PickImageSuccess(images: images));
  }
}
