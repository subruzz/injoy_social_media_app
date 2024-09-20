/// Extension for formatting Duration instances into a human-readable string format.
extension DurationFormatting on Duration {
  /// Returns the Duration formatted as `HH:mm:ss` or `mm:ss`.
  ///
  /// If the duration is greater than one hour, it will be formatted as `HH:mm:ss`.
  /// If the duration is less than one hour, it will be formatted as `mm:ss`.
  ///
  /// Example:
  /// - For a Duration of 3661 seconds, it will return `01:01:01`.
  /// - For a Duration of 120 seconds, it will return `02:00`.
  String videoFormatedDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}
