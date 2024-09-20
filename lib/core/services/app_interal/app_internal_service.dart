import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

/// Initializes the audio recording process.
///
/// This function requests microphone permissions and prepares
/// the audio recorder to start recording.
///
/// [audioRecorder]: The instance of the [AudioRecorder] to be used for recording.
/// Returns `true` if the recording is successfully initialized; otherwise, `false`.
Future<bool> initAudioRecord({required AudioRecorder audioRecorder}) async {
  // Request microphone permission
  final permissionStatus = await Permission.microphone.request();
  if (permissionStatus != PermissionStatus.granted) {
    return false; // Permission denied
  }
  
  // Get the application documents directory
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  
  // Define the file path for the recording
  final String filePath = p.join(appDocDir.path, 'recording.wav');
  
  // Start recording
  await audioRecorder.start(const RecordConfig(), path: filePath);
  return true; // Recording initialized successfully
}
