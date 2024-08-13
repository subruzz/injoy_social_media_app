import 'package:uuid/uuid.dart';

class IdGenerator {
  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}