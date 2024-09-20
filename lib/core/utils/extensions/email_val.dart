/// Extension for adding regex-based validation methods to the `String` class.
extension RegexExt on String {
  /// Validates if the string is a properly formatted email address.
  ///
  /// This method uses a regular expression to check if the string 
  /// matches the standard email format. It returns `true` if the 
  /// email is valid, and `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// String email = "example@example.com";
  /// bool isValid = email.validateEmail(); // Returns true
  /// ```
  bool validateEmail() => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}
