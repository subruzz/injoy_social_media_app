import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';

class CustomChoiceChip extends StatefulWidget {
  final String chipLabel;
  final bool isSelected;
  final Function(bool) onSelected;
  final List<String> selected;
  const CustomChoiceChip({
    super.key,
    required this.chipLabel,
    required this.selected,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: CustomAppPadding(
        padding: AppPadding.horizontalExtraSmall,
        child: Text(
          widget.chipLabel,
        ),
      ),
      selected: widget.selected.contains(widget.chipLabel),
      onSelected: (value) {
        {
          if (widget.selected.contains(widget.chipLabel)) {
            widget.selected.remove(widget.chipLabel);
          } else {
            widget.selected.add(widget.chipLabel);
          }
          setState(() {});
        }
      },
      showCheckmark: false,
    );
  }
}
