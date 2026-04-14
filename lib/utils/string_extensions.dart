import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toDayMonthYearDateParse() {
    if (this != null) {
      try {
        return DateUtils.dayMonthYearTextDateFormat.parse(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
