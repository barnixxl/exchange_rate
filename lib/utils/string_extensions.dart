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
    try {
      final date = DateTime.tryParse(this!);
      if (date != null) {
        return date.toDayMonthYearTextDateFormat();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
