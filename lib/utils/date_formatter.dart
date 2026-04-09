import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
void initializeLocale() {
  initializeDateFormatting('ru', null);
}
extension DateUtils on DateTime {
  String formatDate() {
    return DateFormat('d MMMM y, HH:mm', 'ru').format(this);
  }
}
