import 'package:intl/intl.dart';

/// Extension for formatting DateTime instances into a custom string format.
extension CustomDateTimeFormat on DateTime {
  /// Returns the DateTime formatted as `HH:mm dd MMM yy`.
  ///
  /// Example:
  /// - For a DateTime of `2023-09-20 14:30:00`, it will return `14:30 20 Sep 23`.
  String toCustomFormat() {
    final DateFormat formatter = DateFormat('HH:mm dd MMM yy');
    return formatter.format(this);
  }
}
