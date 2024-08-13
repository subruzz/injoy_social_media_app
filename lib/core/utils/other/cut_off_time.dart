import 'package:cloud_firestore/cloud_firestore.dart';

Timestamp get cutOffTime =>
    Timestamp.fromDate(DateTime.now().subtract(const Duration(hours: 24)));
