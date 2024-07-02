import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_padding.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';

class ColorSelectWidget extends StatelessWidget {
  const ColorSelectWidget(
      {super.key, required this.color, required this.colorCubit});
  final Color color;
  final SelectColorCubit colorCubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => colorCubit.changeColor(color),
      child: Container(
        margin: AppPadding.horizontalSmall,
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: colorCubit.color == color
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
      ),
    );
  }
}
