import 'package:social_media_app/core/utils/extensions/email_val.dart';
import 'package:social_media_app/core/utils/extensions/number_only_string.dart';
import 'package:intl/intl.dart';

/// A class that provides various validation methods for user inputs.
class Validation {
  
  /// Validates an email address.
  /// 
  /// Returns a validation error message if the email is null, empty, or invalid.
  /// Returns null if the email is valid.
  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Please fill in this field";
    } else if (!val.validateEmail()) {
      return "Please enter a valid email";
    }
    return null;
  }

  /// Validates a password.
  /// 
  /// Returns a validation error message if the password is null, empty, 
  /// or less than 6 characters. Returns null if the password is valid.
  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Please fill in this field";
    } else if (val.length < 6) {
      return "Password should be at least 6 characters";
    }
    return null;
  }

  /// Validates a simple input field.
  /// 
  /// Returns a validation error message if the input is null or empty.
  /// Returns null if the input is valid.
  static String? simpleValidation(String? val) {
    if (val == null || val.isEmpty) {
      return "Please fill in this field";
    }
    return null;
  }

  /// Validates a phone number.
  /// 
  /// Returns a validation error message if the phone number is invalid.
  /// Returns null if the phone number is valid or empty.
  static String? phoneNoValidation(String? val) {
    if (val != null && !val.isPhoneNo()) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  /// Validates a date of birth.
  /// 
  /// Returns a validation error message if the date of birth is null, 
  /// empty, invalid, or if the user is under 14 years old.
  /// Returns null if the date of birth is valid.
  static String? dateOfBirthValidation(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) {
      return "Please enter your date of birth";
    }

    try {
      final DateFormat format = DateFormat('dd/MM/yyyy');
      final DateTime selectedDate = format.parse(dateOfBirth);

      // Calculate age
      final currentDate = DateTime.now();
      final age = currentDate.year - selectedDate.year;
      final hasHadBirthdayThisYear =
          (currentDate.month > selectedDate.month) ||
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
