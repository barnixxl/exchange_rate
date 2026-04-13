import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toIsoDateTime() {
    if (this != null) {
      try {
        return DateTimeUtils.formatter.parse(this!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
