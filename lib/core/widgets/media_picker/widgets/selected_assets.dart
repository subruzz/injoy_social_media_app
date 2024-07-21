
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/core/widgets/page_view.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class SelectedAssetsSection extends StatelessWidget {
  const SelectedAssetsSection(
      {super.key,
      required this.pageController,
      this.isPost = false,
      required this.selectedAssets});
  final PageController pageController;
  final List<SelectedByte> selectedAssets;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      pageController: pageController,
      images: selectedAssets,
    );
  }
}
