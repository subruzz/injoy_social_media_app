import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/page_view_indicator.dart';

class SelectedAssetsIndicator extends StatelessWidget {
  const SelectedAssetsIndicator(
      {super.key,
      this.isPost = false,
      required this.pageController,
      required this.selectedAssets});
  final PageController pageController;
  final List<AssetEntity> selectedAssets;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return selectedAssets.length > 1
        ? isPost
            ? PageViewIndicator(
                count: selectedAssets.length,
                pageController: pageController,
              )
            : Positioned(
                bottom: 100,
                child: PageViewIndicator(
                  count: selectedAssets.length,
                  pageController: pageController,
                ),
              )
        : const EmptyDisplay();
  }
}
