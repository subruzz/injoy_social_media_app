import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
// Make sure to import your app colors or any other dependencies
// import 'package:social_media_app/core/theme/color/app_colors.dart';

class CustomChoiceChip extends StatelessWidget {
  final String chipLabel;
  final bool isSelected;
  final Function(bool) onSelected;

  const CustomChoiceChip({
    super.key,
    required this.chipLabel,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          chipLabel,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
      showCheckmark: false,
    );
  }
}
