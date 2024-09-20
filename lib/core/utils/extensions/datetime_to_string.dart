/// Extension for formatting `DateTime` instances.
extension DateFormatter on DateTime {
  /// Returns the date as a formatted string in the format `DD/MM/YYYY`.
  String toFormattedString() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}

/// Extension for providing human-readable date formats.
extension DateTimeExtensions on DateTime {
  /// Returns a string indicating if the date is 'Today', 'Yesterday', 
  /// or a formatted date string `DD/MM/YYYY`.
  String formatDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(year, month, day);

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

/// Extension for providing status view date formats.
extension DateTimeOnStatusView on DateTime {
  /// Returns a string representing the time difference from now, 
  /// such as 'Just now', 'Xm ago', 'Xh ago', or 'Xd ago'.
  String statsuViewFormat() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inDays ~/ 30}mo ago'; // Approximates months
    }
  }
}

/// Extension for formatting dates in a more verbose style.
extension DateTimeFormatter on DateTime {
  /// Returns the date as a formatted string in the format `Month Day, Year`.
  String toFormattedDate() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String month = months[this.month - 1];
    String day = this.day.toString();
    String year = this.year.toString();

    return '$month $day, $year';
  }
}
