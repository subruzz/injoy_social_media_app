import 'package:cloud_firestore/cloud_firestore.dart';

/// Gets a [Timestamp] for the cutoff time, set to 24 hours ago.
///
/// This is used to filter statuses for fetching, ensuring only those created
/// within the last 24 hours are retrieved.
Timestamp get cutOffTime =>
    Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 24)));
