import 'package:flutter/material.dart';

class DescriptionTextfield extends StatelessWidget {
  const DescriptionTextfield({super.key, required this.descriptionController});
  final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: descriptionController,
      decoration: const InputDecoration(
        focusedBorder: InputBorder.none,
        hintText: 'Write a caption and add hashtags...',
        border: InputBorder.none,
        filled: false,
      ),
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
