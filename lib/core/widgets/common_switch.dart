import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CommonSwitch extends StatelessWidget {
  const CommonSwitch({super.key, required this.value, required this.onChanged});
  final bool value;
  final void Function(bool value) onChanged;
  @override
  Widget build(BuildContext context) {
    log('message from pausll all $value');
    return Transform.scale(
      scale: .9,
      child: Switch(
          activeTrackColor: AppDarkColor().buttonBackground,
          activeColor: AppDarkColor().primaryText,
          value: value,
          onChanged: onChanged),
    );
  }
}
