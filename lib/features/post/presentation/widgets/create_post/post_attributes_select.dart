import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/features/assets/presenation/pages/custom_media_picker_page.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/description_textfield.dart';

class PostAttributesSelect extends StatelessWidget {
  const PostAttributesSelect(
      {super.key,
      required this.descriptionController,
      });
  final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return DescriptionTextfield(descriptionController: descriptionController);
  }
}
