import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime? {
  static final DateFormat _formatter = DateFormat('d MMMM y, HH:mm', 'ru');

  String? toDayMonthYearTextDateFormat() {
    if (this != null) {
      return _formatter.format(this!);
    }
    return null;
  }
}
