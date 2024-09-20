/// Extension for adding duration formatting methods to the `int` class.
extension DurationFormatter on int {
  /// Formats the integer as a duration in `MM:SS` format.
  ///
  /// This method takes an integer representing the total number of seconds,
  /// converts it into minutes and remaining seconds, and returns a string
  /// in the format `MM:SS`. The minutes are padded to one digit, and the
  /// seconds are padded to two digits.
  ///
  /// Example:
  /// ```dart
  /// int durationInSeconds = 125;
  /// String formattedDuration = durationInSeconds.formatDuration(); 
  /// print(formattedDuration); // Outputs: "02:05"
  /// ```
  String formatDuration() {
    final int minutes = this ~/ 60;
    final int remainingSeconds = this % 60;
    final String formattedMinutes = minutes.toString().padLeft(1, '0');
    final String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }
}
