import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/features/status/presentation/pages/create_mutliple_status_page.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_text_status/create_text_status_page_builder.dart';

class StatusCreationPage extends StatefulWidget {
  const StatusCreationPage({super.key});

  @override
  State<StatusCreationPage> createState() => _StatusCreationPageState();
}

class _StatusCreationPageState extends State<StatusCreationPage> {
  final TextEditingController _captionController = TextEditingController();
  final List<AssetEntity> _selectedAssets = [];
  bool _isMultipleStatusPage = false;
  @override
  Widget build(BuildContext context) {
    return _isMultipleStatusPage
        // create status with images and caption
        ? CreateMutlipleStatusPage(
            changeScreen: () {
              setState(() {
                _selectedAssets.clear();
                _isMultipleStatusPage = false;
              });
            },
            assets: _selectedAssets,
          )
        // create simple status using texts
        : CreateTextStatusPageBuilder(
            changeStatusScreen: () {
              setState(() {
                _isMultipleStatusPage = true;
              });
            },
            selectedAssets: _selectedAssets,
            captonController: _captionController);
  }
}
