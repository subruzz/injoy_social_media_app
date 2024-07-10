import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/features/assets/presenation/widgets/grid_asset_showing_section/widgets/asset_selectingh_check.dart';
import 'package:social_media_app/features/assets/presenation/widgets/grid_asset_showing_section/widgets/single_asset.dart';

class AssetItems extends StatefulWidget {
  const AssetItems(
      {super.key,
      required this.addToSelected,
      required this.assetEntity,
      required this.selected,
      this.mainAsset,
      required this.isPost});

  final VoidCallback addToSelected;
  final AssetEntity assetEntity;
  final List<AssetEntity> selected;
  final bool isPost;
  final ValueNotifier<AssetEntity?>? mainAsset;

  @override
  State<AssetItems> createState() => _AssetItemsState();
}

class _AssetItemsState extends State<AssetItems> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.selected.contains(widget.assetEntity);
    super.initState();
  }

  void onselect() {
    setState(() {
      if (isSelected) {
        widget.mainAsset!.value = widget.assetEntity;

        HapticFeedback.vibrate();
        widget.selected.remove(widget.assetEntity);
      } else {
        if (widget.selected.length < 3) {
          widget.mainAsset!.value = widget.assetEntity;
        }
        if (widget.selected.length >= 3) {
          Messenger.showSnackBar(
              message: 'You can only select maximum of 3 images');
          return;
        }
        HapticFeedback.vibrate();
        widget.selected.add(widget.assetEntity);
      }
      isSelected = !isSelected;
    });
    widget.addToSelected();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onselect,
      onTap: () {
        if (widget.selected.isNotEmpty) {
          onselect();

          return;
        }
        if (!widget.isPost) {
          onselect();
        } else {
          widget.mainAsset!.value = widget.assetEntity;
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: SingleAsset(
                  isSelected: isSelected, assetEntity: widget.assetEntity)),
          if (isSelected)
            const Positioned(
                top: 8, right: 8, child: AssetSelectinghCheckIcon()),
        ],
      ),
    );
  }
}
