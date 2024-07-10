import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/page_view.dart';

class SelectedAssetsSection extends StatelessWidget {
  const SelectedAssetsSection(
      {super.key,
      required this.pageController,
      this.isPost = false,
      required this.selectedAssets});
  final PageController pageController;
  final List<AssetEntity> selectedAssets;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return !isPost
        ? CustomPageView(
            pageController: pageController,
            selectedStatusAssets: selectedAssets,
          )
        : Expanded(
            child: CustomPageView(
              pageController: pageController,
              selectedStatusAssets: selectedAssets,
            ),
          );
  }
}
