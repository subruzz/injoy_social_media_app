extension StringExtension on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}

