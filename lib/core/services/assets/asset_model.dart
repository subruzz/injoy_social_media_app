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
  File selectedFile; 
  MediaType mediaType;

  SelectedByte({
    required this.mediaType,
    required this.selectedFile
  });
}

enum MediaType {
  audio,
  video,
  photo,
  none,
}
