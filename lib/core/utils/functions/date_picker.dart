import 'package:flutter/material.dart';
import 'package:social_media_app/core/extensions/datetime_to_string.dart';

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
