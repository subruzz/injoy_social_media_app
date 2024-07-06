extension StringExtension on String {
  bool isPhoneNo() {
    // Check if the string consists only of digits and has a length of 10
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }
}
