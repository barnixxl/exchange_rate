import 'package:intl/intl.dart';

extension DateUtils on DateTime? {
  static final DateFormat dayMonthYearTextDateFormat =
      DateFormat('d MMMM y, HH:mm', 'ru');

  String? toDayMonthYearTextDateFormat() {
    if (this != null) {
      return dayMonthYearTextDateFormat.format(this!);
    }
    return null;
  }
}
