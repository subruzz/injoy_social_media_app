import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class SelectedImageOnlyButton extends StatelessWidget {
  const SelectedImageOnlyButton({
    super.key,
    required this.isSelectedEmpty,
    required this.onPressed,
    required this.pickerType,
  });
  final MediaPickerType pickerType;
  final ValueNotifier<bool> isSelectedEmpty;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelectedEmpty,
      builder: (context, value, child) {
        return value
            ? FloatingActionButton(
                heroTag: 1,
                shape: OutlineInputBorder(borderRadius: AppBorderRadius.medium),
                onPressed: onPressed,
                // Display check icon
                child: Icon(
                  Icons.check_rounded,
                  color: AppDarkColor().iconPrimaryColor,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
