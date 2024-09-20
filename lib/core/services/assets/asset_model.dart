import 'dart:io';

/// A class representing the details of selected images or media files.
class SelectedImagesDetails {
  List<SelectedByte> selectedFiles; // A list of selected media files.
  bool multiSelectionMode; // Indicates if multiple selection mode is enabled.

  SelectedImagesDetails({
    required this.selectedFiles,
    required this.multiSelectionMode,
  });
}

/// A class representing a selected media file along with its type.
class SelectedByte {
  File selectedFile; // The selected media file.
  MediaType mediaType; // The type of the media (audio, video, photo, etc.).

  SelectedByte({
    required this.mediaType,
    required this.selectedFile,
  });
}

/// An enum representing different media types.
enum MediaType {
  audio, // Represents audio media type.
  video, // Represents video media type.
  photo, // Represents photo media type.
  none,  // Represents no media type.
}
