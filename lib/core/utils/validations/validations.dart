import 'package:social_media_app/core/extensions/email_val.dart';
import 'package:social_media_app/core/extensions/number_only_string.dart';

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
}
