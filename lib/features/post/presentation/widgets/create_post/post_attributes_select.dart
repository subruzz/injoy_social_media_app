import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/media_picker/custom_media_picker_page.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/description_textfield.dart';

class PostAttributesSelect extends StatelessWidget {
  const PostAttributesSelect(
      {super.key,
      required this.descriptionController,
      required this.selectedAssets});
  final TextEditingController descriptionController;
  final ValueNotifier<List<AssetEntity>> selectedAssets;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final List<AssetEntity>? res = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => CustomMediaPickerPage(
                        alreadySelected: selectedAssets.value)));
            if (res != null) {
              selectedAssets.value = res;
            }
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
