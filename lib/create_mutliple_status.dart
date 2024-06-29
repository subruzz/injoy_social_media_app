import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/create_post/presentation/widgets/select_post/page_view_indicator.dart';
import 'package:social_media_app/sample.dart';

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
    // Initialize captions list with empty strings
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
    final pageIndex = _pageController.page!.round();
    _captionController.text = _captions[pageIndex];
  }

  void _onCaptionChanged(String value) {
    final pageIndex = _pageController.page!.round();
    // Update the caption for the current page
    _captions[pageIndex] = value;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
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
            ValueListenableBuilder(
              valueListenable: _selectedAssets,
              builder: (context, value, child) {
                return PageView.builder(
                  onPageChanged: (index) {
                    print(index);
                  },
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    print('new state');
                    return AssetEntityImage(
                      height: double.infinity,
                      width: double.infinity,
                      value[index],
                      isOriginal: false,
                      thumbnailSize: const ThumbnailSize.square(500),
                    );
                  },
                  // Sync the small preview with the main PageView
                  controller: _pageController,
                );
              },
            ),
            // Main PageView for displaying full-sized images

            // Positioned widget for small thumbnail preview above caption input
            ValueListenableBuilder(
              valueListenable: _selectedAssets,
              builder: (context, value, child) {
                return value.isNotEmpty
                    ? Positioned(
                        bottom: 100,
                        child: PageViewIndicator(
                          count: value.length,
                          pageController: _pageController,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),

            // Positioned widget for caption input and post button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.black,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _captionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () async {
                              final List<AssetEntity>? res =
                                  await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Media(
                                              alreadySelected:
                                                  _selectedAssets.value)));
                              if (res != null) {
                                _selectedAssets.value = res;
                                _captions =
                                    List.generate(res.length, (index) => '');
                                _captionController.clear();
                                widget.assets.clear();
                              }
                            },
                            icon: const Icon(Icons.photo_library),
                            color: AppDarkColor().iconSoftColor,
                          ),
                          hintText: 'Add a caption...',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppDarkColor().softBackground, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: AppDarkColor().background,
                        ),
                        onChanged: _onCaptionChanged,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(5),
                      ),
                      child: const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
