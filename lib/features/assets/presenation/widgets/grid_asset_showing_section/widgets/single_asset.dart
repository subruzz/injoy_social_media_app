import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class SingleAsset extends StatelessWidget {
  const SingleAsset(
      {super.key, required this.isSelected, required this.assetEntity});
  final bool isSelected;
  final AssetEntity assetEntity;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: isSelected ? 3 : 1,
          color: isSelected
              ? AppDarkColor().iconSecondarycolor
              : Colors.transparent,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AssetEntityImage(
          assetEntity,
          isOriginal: false,
          thumbnailSize: const ThumbnailSize.square(250),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
