/// Extension for adding phone number validation methods to the `String` class.
extension StringExtension on String {
  /// Validates if the string is a valid phone number.
  ///
  /// This method checks if the string consists only of digits 
  /// and has a length of exactly 10 characters. It returns `true` 
  /// if the string matches these criteria, and `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// String phoneNumber = "1234567890";
  /// bool isValid = phoneNumber.isPhoneNo(); // Returns true
  /// ```
  bool isPhoneNo() {
    // Check if the string consists only of digits and has a length of 10
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}
