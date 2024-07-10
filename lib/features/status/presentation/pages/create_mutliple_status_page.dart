import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_multiple_status/multiple_status_input_bar.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets.dart';
import 'package:social_media_app/core/widgets/media_picker/widgets/selected_assets_indicator.dart';
import 'package:social_media_app/features/status/presentation/widgets/status_app_bar.dart';

class CreateMutlipleStatusPage extends StatefulWidget {
  const CreateMutlipleStatusPage(
      {super.key, required this.assets, required this.changeScreen});
  final List<AssetEntity> assets;
  final VoidCallback changeScreen;

  @override
  State<CreateMutlipleStatusPage> createState() =>
      _CreateMutlipleStatusPageState();
}

class _CreateMutlipleStatusPageState extends State<CreateMutlipleStatusPage> {
  final PageController _pageController = PageController();
  final TextEditingController _captionController = TextEditingController();
  List<String> _captions = [];
  final ValueNotifier<List<AssetEntity>> _selectedAssets = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
    _selectedAssets.value = widget.assets;
    // Initializing captions list with empty strings
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
    //this for selecting different captions for differnt images
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
      appBar: const StatusAppBar(actions: []),
      body: Stack(
        alignment: Alignment.center,
        children: [
          //shows the selected assets
          Hero(
            tag: widget.assets[0],
            child: SelectedAssetsSection(
                pageController: _pageController,
                selectedAssets: _selectedAssets.value),
          ),
          //shows the pageview indicator
          SelectedAssetsIndicator(
              pageController: _pageController,
              selectedAssets: _selectedAssets.value),
          //input bar for adding caption
          MultipleStatusInputBar(
              captionController: _captionController,
              alreadySelected: _selectedAssets.value,
              captions: _captions,
              onCaptionChanged: _onCaptionChanged,
              leadingIconPressed: () async {
                final List<AssetEntity>? res = await context
                    .pushNamed(MyAppRouteConst.mediaPickerRoute, extra: {
                  'selectedAssets': widget.assets,
                });
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
