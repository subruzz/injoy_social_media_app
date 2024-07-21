
import 'package:flutter/widgets.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post_input_section/widget/description_textfield.dart';

class PostInputSection extends StatelessWidget {
  const PostInputSection(
      {super.key,
      required this.descriptionController,
      required this.assetEntity});
  final TextEditingController descriptionController;
  final SelectedByte assetEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: DescriptionTextfield(
          descriptionController: descriptionController,
          onChanged: (value) {},
        )),
        ClipRRect(
          borderRadius: AppBorderRadius.small,
          child: Image.file(
            height: 50,
            assetEntity.selectedFile!,
          ),
        )
      ],
    );
  }
}
