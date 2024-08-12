import 'package:flutter/material.dart';

import '../../../../../../../../core/const/extensions/localization.dart';

class DescriptionTextfield extends StatelessWidget {
  const DescriptionTextfield(
      {super.key,
      required this.descriptionController,
      required this.onChanged,
      required this.l10n});
  final TextEditingController descriptionController;
  final Function(String value) onChanged;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: descriptionController,
      decoration:  InputDecoration(
        focusedBorder: InputBorder.none,
        hintText: l10n.writeCaptionAndHashtag,
        border: InputBorder.none,
        filled: false,
      ),
      maxLines: null,
      onChanged: (value) {
        onChanged(value);
      },
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
