extension StringExtension on String {
  bool isPhoneNo() {
    return( double.tryParse(this) != null)&&(length==10);
  }
}

