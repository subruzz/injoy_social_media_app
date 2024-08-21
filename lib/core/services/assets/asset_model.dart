import 'dart:io';
class SelectedImagesDetails {
  List<SelectedByte> selectedFiles;
  bool multiSelectionMode;

  SelectedImagesDetails({
    required this.selectedFiles,
    required this.multiSelectionMode,
  });
}

class SelectedByte {
  File? selectedFile; // File may be null for web
  MediaType mediaType;

  SelectedByte({
    required this.mediaType,
    this.selectedFile, // Optional for web
  });
}

enum MediaType {
  audio,
  video,
  photo,
  none,
}

