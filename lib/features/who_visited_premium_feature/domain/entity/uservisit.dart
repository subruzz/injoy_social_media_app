import 'package:social_media_app/core/common/models/partial_user_model.dart';

enum TimeFrame { today, lastWeek, lastMonth, older }

class UserVisit {
  final PartialUser user;
  final DateTime timestamp;

  UserVisit({required this.user, required this.timestamp});
}

class CategorizedVisits {
  final List<UserVisit> todayVisits;
  final List<UserVisit> lastWeekVisits;
  final List<UserVisit> lastMonthVisits;
  final List<UserVisit> olderVisits;

  CategorizedVisits({
    required this.todayVisits,
    required this.lastWeekVisits,
    required this.lastMonthVisits,
    required this.olderVisits,
  });
}

CategorizedVisits categorizeVisits(List<UserVisit> visits) {
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  DateTime startOfMonth = DateTime(now.year, now.month, 1);

  List<UserVisit> todayVisits = [];
  List<UserVisit> lastWeekVisits = [];
  List<UserVisit> lastMonthVisits = [];
  List<UserVisit> olderVisits = [];

  for (var visit in visits) {
    DateTime visitDate = visit.timestamp;

    if (visitDate.year == now.year &&
        visitDate.month == now.month &&
        visitDate.day == now.day) {
      todayVisits.add(visit);
    } else if (visitDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
               visitDate.isBefore(now)) {
      lastWeekVisits.add(visit);
    } else if (visitDate.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
               visitDate.isBefore(now)) {
      lastMonthVisits.add(visit);
    } else {
      olderVisits.add(visit);
    }
  }

  return CategorizedVisits(
    todayVisits: todayVisits,
    lastWeekVisits: lastWeekVisits,
    lastMonthVisits: lastMonthVisits,
    olderVisits: olderVisits,
  );
}
