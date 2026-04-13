import 'package:intl/intl.dart';

final DateFormat dayMonthYearTextDateFormat =
    DateFormat('d MMMM y, HH:mm', 'ru');

extension DateTimeUtils on DateTime? {
  String? toDayMonthYearTextDateFormat() {
    if (this != null) {
      return dayMonthYearTextDateFormat.format(this!);
    }
    return null;
  }
}
