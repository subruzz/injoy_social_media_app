import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:social_media_app/core/widgets/media_picker/custom_media_picker_page.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_multiple_status/multiple_status_input_bar.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets_indicator.dart';

class MyPageViewScreen extends StatefulWidget {
  const MyPageViewScreen(
      {super.key, required this.assets, required this.changeScreen});
  final List<AssetEntity> assets;
  final VoidCallback changeScreen;

  @override
  State<MyPageViewScreen> createState() => _MyPageViewScreenState();
}

class _MyPageViewScreenState extends State<MyPageViewScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _captionController = TextEditingController();
  List<String> _captions = [];
  final ValueNotifier<List<AssetEntity>> _selectedAssets = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    // Initializing captions list with empty strings
    _selectedAssets.value = widget.assets;
    _captions = List.generate(widget.assets.length, (index) => '');
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    //controller will listen to change and update here
    //this for selecting different captions for differnt pics
    final pageIndex = _pageController.page!.round();
    _captionController.text = _captions[pageIndex];
  }

  void _onCaptionChanged(String value) {
    final pageIndex = _pageController.page!.round();
    // Updating the caption for the current page
    _captions[pageIndex] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Status'),
        leading: IconButton(
          onPressed: () {
            widget.changeScreen();
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SelectedAssetsPageView(
              pageController: _pageController, selectedAssets: _selectedAssets),
          SelectedAssetsIndicator(
              pageController: _pageController, selectedAssets: _selectedAssets),
          MultipleStatusInputBar(
              captionController: _captionController,
              alreadySelected: _selectedAssets.value,
              captions: _captions,
              onCaptionChanged: _onCaptionChanged,
              leadingIconPressed: () async {
                final List<AssetEntity>? res = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => CustomMediaPickerPage(
                            alreadySelected: _selectedAssets.value)));
                if (res != null) {
                  _selectedAssets.value = res;
                  _captions = List.generate(res.length, (index) => '');
                  _captionController.clear();
                  widget.assets.clear();
                }
              }),
        ],
      ),
    );
  }
}
