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

  String? toDayMonthYearTextDateFormat() {
    if (this == null) {
      return null;
    }
    try {
      final date = DateTime.tryParse(this!);
      if (date == null) {
        return null;
      }
      return date.toDayMonthYearTextDateFormat();
    } catch (e) {
      return null;
    }
  }
}
