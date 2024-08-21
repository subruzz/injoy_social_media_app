import 'package:flutter/material.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/status/presentation/pages/create_mutliple_status_page.dart';
import 'package:social_media_app/features/status/presentation/widgets/create_multiple_status/create_text_status_page_builder.dart';

class StatusCreationPage extends StatefulWidget {
  const StatusCreationPage({super.key});

  @override
  State<StatusCreationPage> createState() => _StatusCreationPageState();
}

class _StatusCreationPageState extends State<StatusCreationPage> {
  final TextEditingController _captionController = TextEditingController();
  final List<SelectedByte> _selectedAssets = [];
  bool _isMultipleStatusPage = false;
  @override
  Widget build(BuildContext context) {
    return _isMultipleStatusPage
        ? CreateMutlipleStatusPage(
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
