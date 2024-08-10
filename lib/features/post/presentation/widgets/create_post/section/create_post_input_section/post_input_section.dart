import 'package:flutter/widgets.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/extensions/localization.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

import 'widgets/desc_text_field.dart';

class PostInputSection extends StatelessWidget {
  const PostInputSection(
      {super.key,
      required this.descriptionController,
      required this.assetEntity,
      required this.l10n});
  final TextEditingController descriptionController;
  final SelectedByte assetEntity;
  final AppLocalizations l10n;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: DescriptionTextfield(
          l10n: l10n,
          descriptionController: descriptionController,
          onChanged: (value) {},
        )),
        if (assetEntity.mediaType == MediaType.photo)
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
