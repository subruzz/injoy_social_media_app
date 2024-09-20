/// Extension for adding time-related methods to the `DateTime` class.
extension TimeAgo on DateTime {
  /// Returns a human-readable string representing the time elapsed since the
  /// DateTime instance.
  ///
  /// For example:
  /// - If the instance was 30 seconds ago, returns '30s'.
  /// - If it was 5 minutes ago, returns '5m'.
  /// - If it was 3 days ago, returns '3d'.
  /// - If it was more than a year ago, returns 'Xy'.
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w';
    } else if (difference.inDays < 365) {
      final weeks = (difference.inDays / 7).round();
      return '${weeks}w';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y';
    }
  }
}

/// Extension for formatting DateTime instances into a 12-hour clock format.
extension TimeFormat on DateTime {
  /// Returns the time formatted in `hh:mm AM/PM` format.
  String to12HourFormat() {
    final hour = this.hour;
    final minute = this.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }
}

/// Extension for custom date formatting for DateTime instances.
extension CustomDateFormat on DateTime {
  /// Returns a custom formatted string based on the date.
  ///
  /// - If the date is today, returns the time in 12-hour format.
  /// - If the date was yesterday, returns 'Yesterday'.
  /// - Otherwise, returns a short date string in `MM/DD/YYYY` format.
  String toCustomFormat() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final date = DateTime(year, month, day);

    if (date == today) {
      return to12HourFormat();
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return toShortDateString();
    }
  }

  /// Helper method to convert DateTime to a short date string (e.g., "MM/DD/YYYY").
  String toShortDateString() {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$month/$day/$year';
  }
}

/// Extension for displaying online status based on DateTime instances.
extension TimeAgoOnlineStatus on DateTime {
  /// Returns a human-readable string indicating how long ago the user was online.
  ///
  /// - If the user was online less than a minute ago, returns 'Just now'.
  /// - If it was an hour ago, returns 'X hours ago'.
  /// - If it was more than a week ago, returns a formatted date string.
  String onlineStatus() {
    final now = DateTime.now();
    final duration = now.difference(this);

    if (duration.inMinutes < 1) {
      return 'Just now';
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''} ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''} ago';
    } else if (duration.inDays < 2) {
      return 'Yesterday at ${_formatTime(this)}';
    } else if (duration.inDays < 7) {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago';
    } else {
      return _formatFullDate(this);
    }
  }

  String _formatTime(DateTime dateTime) {
    final hourStr = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
    final minuteStr = dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute.toString();
    return '$hourStr:$minuteStr';
  }

  String _formatFullDate(DateTime dateTime) {
    final monthStr = _monthToString(dateTime.month);
    final dayStr = dateTime.day < 10 ? '0${dateTime.day}' : dateTime.day.toString();
    final yearStr = dateTime.year.toString();
    return 'Last seen $monthStr $dayStr, $yearStr';
  }

  String _monthToString(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }
}
