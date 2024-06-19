import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/services/image_pick_services/image_picker.dart';

part 'pick_image_state.dart';

class PickSingleImageCubit extends Cubit<PickSingleImageState> {
  File? img;

  PickSingleImageCubit() : super(PickImageInitial());

  Future<void> pickImage() async {
    try {
      emit(PickImageLoading());
      final image = await ImagePickerService.pickOneImage();
      if (image != null) {
        img = image;
      } else {
        emit(PickImageFailure('No image selected'));
      }
    } catch (e) {
      emit(PickImageFailure(e.toString()));
    }
  }
}
