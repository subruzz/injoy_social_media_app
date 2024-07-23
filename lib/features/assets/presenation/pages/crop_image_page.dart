import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/page_view.dart';
import 'package:social_media_app/core/widgets/page_view_indicator.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class CropImagePage extends StatefulWidget {
  const CropImagePage(
      {super.key, required this.selectedImages, required this.pickerType});
  final SelectedImagesDetails selectedImages;
  final MediaPickerType pickerType;
  @override
  State<CropImagePage> createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppCustomFloatingButton(
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          if (widget.pickerType == MediaPickerType.post) {
            Navigator.pushNamed(
              context,
              MyAppRouteConst.createPostRoute,
              arguments: widget.selectedImages.selectedFiles,
            );
          } else {
            Navigator.pushNamed(
              context,
              MyAppRouteConst.createMultipleStatusRoute,
              arguments: {
                'selectedAssets': widget.selectedImages.selectedFiles,
                'isChat': widget.pickerType == MediaPickerType.chat,
              },
            );
          }
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                int currentIndex = pageController.page?.round() ?? 0;
                if (widget
                        .selectedImages.selectedFiles[currentIndex].mediaType ==
                    MediaType.video) {
                  return;
                }

                final croppedImage = await cropImage(widget
                    .selectedImages.selectedFiles[currentIndex].selectedFile!);
                // Update the selected image list
                setState(() {
                  widget.selectedImages.selectedFiles[currentIndex]
                      .selectedFile = croppedImage;
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
              images: widget.selectedImages.selectedFiles,
            ),
          ),
          if (widget.selectedImages.selectedFiles.length > 1)
            PageViewIndicator(
                pageController: pageController,
                count: widget.selectedImages.selectedFiles.length)
        ],
      ),
    );
  }
}

Future<File> cropImage(File imageData) async {
  log('is it null? $imageData');
  // Create a temporary file from Uint8List
  // final tempDir = await getTemporaryDirectory();
  // final tempFile =
  //     await File('${tempDir.path}/temp_image').writeAsBytes(imageData);

  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imageData.path,
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
  log('it is null $croppedFile');
  if (croppedFile != null) {
    return File(croppedFile.path);
  } else {
    return imageData;
  }
}
