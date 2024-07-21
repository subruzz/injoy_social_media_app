import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

Future<void> initAudioRecord({required AudioRecorder audioRecorder}) async {
  final permissionStatus = await Permission.microphone.request();
  if (permissionStatus != PermissionStatus.granted) {
    throw 'Microphone Permission not granted';
  }
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String filePath = p.join(appDocDir.path, 'recording.wav');
  await audioRecorder.start(const RecordConfig(), path: filePath);
}
