import 'package:flutter/material.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/features/create_post/presentation/widgets/create_post/description_textfield.dart';

class PostAttributesSelect extends StatelessWidget {
  const PostAttributesSelect(
      {super.key,
      required this.pickMultipleImageCubit,
      required this.descriptionController});
  final PickMultipleImageCubit pickMultipleImageCubit;
  final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            pickMultipleImageCubit.pickImage();
          },
          icon: const Icon(
            Icons.photo_camera_outlined,
          ),
        ),
        Expanded(
          child: DescriptionTextfield(
              descriptionController: descriptionController),
        ),
      ],
    );
  }
}
