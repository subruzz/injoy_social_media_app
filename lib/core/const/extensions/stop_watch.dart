extension DurationFormatter on int {
  String formatDuration() {
    final int minutes = this ~/ 60;
    final int remainingSeconds = this % 60;
    final String formattedMinutes = minutes.toString().padLeft(1, '0');
    final String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }
}
