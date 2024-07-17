import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/page_view.dart';
import 'package:social_media_app/core/widgets/page_view_indicator.dart';

class CropImagePage extends StatefulWidget {
  const CropImagePage({super.key, required this.selectedImages});
  final List<File> selectedImages;

  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppCustomFloatingButton(
        child: Text('df'),
        onPressed: () {},
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                int currentIndex = pageController.page?.round() ?? 0;

                final croppedImage =
                    await cropImages(widget.selectedImages[currentIndex]);
                // Update the selected image list
                setState(() {
                  widget.selectedImages[currentIndex] = croppedImage;
                });
              },
              icon: const Icon(Icons.crop))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomPageView(
              pageController: pageController,
              images: widget.selectedImages,
            ),
          ),
          if (widget.selectedImages.length > 1)
            PageViewIndicator(
                pageController: pageController,
                count: widget.selectedImages.length)
        ],
      ),
    );
  }
}

Future<File> cropImages(File image) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: image.path,
    uiSettings: [
      AndroidUiSettings(
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9,
        ],
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
  );

  return File(croppedFile!.path);
}
