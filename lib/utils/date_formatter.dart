import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat dayMonthYearTextDateFormat =
  DateFormat('d MMMM y, HH:mm', 'ru');
}
extension DateTimeUtils on DateTime? {
  String? toDayMonthYearTextDateFormat() {
    if (this != null) {
      return DateFormatter.dayMonthYearTextDateFormat.format(this!);
    }
    return null;
  }
}
