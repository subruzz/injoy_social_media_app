extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
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
