extension TimeAgo on DateTime {
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

extension TimeFormat on DateTime {
  String to12HourFormat() {
    final hour = this.hour;
    final minute = this.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    final formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }
}

extension CustomDateFormat on DateTime {
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

  // Helper method to convert DateTime to a short date string (e.g., "MMM dd, yyyy")
  String toShortDateString() {
    final year = this.year.toString();
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$month/$day/$year';
  }
}

extension TimeAgoOnlineStatus on DateTime {
  String onlineStatus() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final lastSeenThreshold =
        now.subtract(const Duration(minutes: 5)); // Adjust threshold as needed

    if (isAfter(today) && isBefore(lastSeenThreshold)) {
      // If the user was seen within the last 5 minutes
      return 'Online now';
    } else if (isAfter(today)) {
      // If the user was seen today but not within the last 5 minutes
      final hourStr = hour < 10 ? '0$hour' : hour.toString();
      final minuteStr = minute < 10 ? '0$minute' : minute.toString();
      return 'Last seen today at $hourStr:$minuteStr';
    } else if (isAfter(yesterday) && isBefore(today)) {
      // If the user was seen yesterday
      final hourStr = hour < 10 ? '0$hour' : hour.toString();
      final minuteStr = minute < 10 ? '0$minute' : minute.toString();
      return 'Last seen yesterday at $hourStr:$minuteStr';
    } else {
      // For dates older than yesterday
      final monthStr = _monthToString(month);
      final dayStr = day < 10 ? '0$day' : day.toString();
      final yearStr = year.toString();
      return 'Last seen $monthStr $dayStr, $yearStr';
    }
  }

  String _monthToString(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
