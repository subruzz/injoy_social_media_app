import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:social_media_app/core/const/extensions/email_val.dart';
import 'package:social_media_app/core/const/extensions/number_only_string.dart';

class Validation {
  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Please fill in this field";
    } else if (!val.validateEmail()) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Please fill in this Field.";
    } else if (val.length < 6) {
      return "Password should be at least 6 characters";
    }
    return null;
  }

  static String? simpleValidation(String? val) {
    if (val!.isEmpty) {
      return "Please fill in this field";
    }
    return null;
  }

  static String? phoneNoValidation(String? val) {
    if (val!.isEmpty) {
      return null;
    }
    if (!val.isPhoneNo()) {
      return "Please fill in this field";
    }
    return null;
  }

  static String? dateOfBirthValidation(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) {
      return "Please enter your date of birth";
    }

    try {
      // Expected format: dd/MM/yyyy
      final parts = dateOfBirth.split('/');
      if (parts.length != 3) {
        return 'Invalid date of birth';
      }

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Check if date is valid
      final selectedDate = DateTime(year, month, day);
      if (selectedDate.day != day ||
          selectedDate.month != month ||
          selectedDate.year != year) {
        return 'Invalid date of birth';
      }

      // Calculate age
      final currentDate = DateTime.now();
      final age = currentDate.year - selectedDate.year;
      final hasHadBirthdayThisYear = (currentDate.month > selectedDate.month) ||
          (currentDate.month == selectedDate.month &&
              currentDate.day >= selectedDate.day);

      if (age > 14 || (age == 14 && hasHadBirthdayThisYear)) {
        return null; // Date is valid (user is at least 14 years old)
      } else {
        return "You must be at least 14 years old";
      }
    } catch (e) {
      return "Invalid date format";
    }
  }
}
