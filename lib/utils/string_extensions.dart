import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toIsoDateTime() {
    if (this != null) {
      try {
        return DateTimeUtils.parseDayMonthYearText(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
