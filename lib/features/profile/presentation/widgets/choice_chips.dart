import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
// Make sure to import your app colors or any other dependencies
// import 'package:social_media_app/core/theme/color/app_colors.dart';

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
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          widget.chipLabel,
          style: Theme.of(context).textTheme.labelMedium,
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
          print(widget.selected);
          setState(() {});
        }
      },
      showCheckmark: false,
    );
  }
}
