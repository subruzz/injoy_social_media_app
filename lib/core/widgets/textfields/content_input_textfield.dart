import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ContentInputTextfield extends StatelessWidget {
  const ContentInputTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.leadingPressed,
    this.onChanged,
  });
  final TextEditingController controller;
  final String hintText;
  final Icon? prefixIcon;
  final VoidCallback? leadingPressed;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: AppDarkColor().primaryText),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? IconButton(onPressed: () => leadingPressed, icon: prefixIcon!)
            : null,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppDarkColor().softBackground, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: AppDarkColor().background,
      ),
      onChanged: onChanged,
    );
  }
}
