import 'package:social_media_app/core/extensions/email_val.dart';

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
}
