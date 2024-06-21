import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/services/image_pick_services/image_picker.dart';

part 'pick_image_state.dart';

class PickSingleImageCubit extends Cubit<PickSingleImageState> {
  File? img;

  PickSingleImageCubit() : super(PickSingleImageInitial());

  Future<void> pickImage() async {
    try {
      emit(PickSingleImageLoading());
      final image = await ImagePickerService.pickOneImage();
      if (image != null) {
        img = image;
        emit(PickSingleImageSuccess(img: image));
      } else {
        emit(PickSingleImageFailure('No image selected'));
      }
    } catch (e) {
      emit(PickSingleImageFailure(e.toString()));
    }
  }
}
