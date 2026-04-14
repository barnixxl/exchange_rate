import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toApiOrDisplayDateParse() {
    if (this != null) {
      try {
        final parsedIso = DateTime.tryParse(this!);
        if (parsedIso != null) {
          return parsedIso;
        }
        return DateUtils.dayMonthYearTextDateFormat.parse(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
