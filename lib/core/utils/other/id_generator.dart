import 'package:uuid/uuid.dart';

/// A utility class for generating unique identifiers.
class IdGenerator {
  /// Generates a unique identifier using UUID version 4.
  ///
  /// This method creates a random UUID that can be used as a unique identifier
  /// for various purposes, such as database records or object IDs.
  ///
  /// Returns:
  /// A [String] representing the generated unique identifier.
  static String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}
