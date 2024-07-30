import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class TextStatusInputField extends StatelessWidget {
  const TextStatusInputField(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      maxLines: null,
      style: Theme.of(context).textTheme.displayMedium,
      decoration: 
      
      InputDecoration(
        hintStyle: TextStyle(
            fontWeight: FontWeight.bold, color: AppDarkColor().primaryText),
        hintText: 'Write your thought\n with others',
        focusedErrorBorder: InputBorder.none,
        filled: false,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }
}
