import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toIsoDateTime() {
    if (this != null) {
      try {
        return DateTime.tryParse(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}

String? toDayMonthYearTextDateFormat(DateTime? date) {
  if (date != null) {
    return dayMonthYearTextDateFormat.format(date);
  }
  return null;
}
