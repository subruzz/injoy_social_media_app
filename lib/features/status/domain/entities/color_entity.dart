
import 'package:flutter/material.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';

class ColorData {
  final Color color;
  final SelectColorCubit colorCubit;

  ColorData({required this.color, required this.colorCubit});

  static List<ColorData>  colorItems(SelectColorCubit colorCubit){ return [
        ColorData(color: Colors.green, colorCubit: colorCubit),
        ColorData(
            color: Colors.yellow.withOpacity(0.8), colorCubit: colorCubit),
        ColorData(color: Colors.blue, colorCubit: colorCubit),
        ColorData(color: Colors.red, colorCubit: colorCubit),
        ColorData(color: Colors.pink, colorCubit: colorCubit),];
  }
}
