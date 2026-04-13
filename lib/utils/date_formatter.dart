import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime? {
  static final DateFormat formatter = DateFormat('d MMMM y, HH:mm', 'ru');

  String? toDayMonthYearTextDateFormat() {
    if (this != null) {
      return formatter.format(this!);
    }
    return null;
  }
}
