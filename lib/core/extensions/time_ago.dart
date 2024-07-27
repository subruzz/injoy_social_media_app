extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} sec ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}

extension TimeAgoChatExtension on DateTime {
  String timeAgoChatExtension() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (isAfter(today)) {
      // Today's message: show time without AM/PM
      final hourStr = hour < 10 ? '0$hour' : hour.toString();
      final minuteStr = minute < 10 ? '0$minute' : minute.toString();
      return '$hourStr:$minuteStr';
    } else if (isAfter(yesterday)) {
      // Yesterday's message: show "Yesterday"
      return 'Yesterday';
    } else {
      // Older than yesterday: show date
      final monthStr = month < 10 ? '0$month' : month.toString();
      final dayStr = day < 10 ? '0$day' : day.toString();
      return '$monthStr/$dayStr/$year';
    }
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
