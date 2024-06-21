import 'package:intl/intl.dart';

extension CustomDateTimeFormat on DateTime {
  String toCustomFormat() {
    final DateFormat formatter = DateFormat('HH:mm dd MMM yy');
    return formatter.format(this);
  }
}
