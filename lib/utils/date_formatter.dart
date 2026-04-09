import 'package:intl/intl.dart';

final DateFormat dayMonthYearTextDateFormat =
    DateFormat('d MMMM y, HH:mm', 'ru');

String? toDayMonthYearTextDateFormat(DateTime? date) {
  if (date != null) return dayMonthYearTextDateFormat.format(date);
  return null;
}
