import 'package:intl/intl.dart';

final DateFormat dayMonthYearTextDateFormat =
    DateFormat('d MMMM y, HH:mm', 'ru');

extension DateTimeUtils on DateTime {
  String toDayMonthYearTextDateFormat() {
    return dayMonthYearTextDateFormat.format(this);
  }
}
