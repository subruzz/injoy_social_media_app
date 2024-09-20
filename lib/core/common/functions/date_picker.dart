import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/extensions/datetime_to_string.dart';

/// Displays a date picker dialog and returns the selected date as a formatted string.
///
/// If no date is selected, it returns null.
///
/// The date picker allows selection of dates from the year 1900 to the current date.
/// 
/// [context] - The BuildContext in which the date picker is displayed.
/// 
/// Returns a [Future<String?>] containing the formatted date string or null if no date was selected.
Future<String?> pickDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (pickedDate == null) return null;
  return pickedDate.toFormattedString();
}

/// A typedef for a function that picks a date.
///
/// This function takes a [BuildContext] and returns a [Future<String?>] containing
/// the formatted date string or null if no date was selected.
typedef DatePickerFunction = Future<String?> Function(BuildContext context);
