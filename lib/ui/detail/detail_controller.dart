import '../../models/rate_data.dart';
import 'package:currency_converter/utils/date_formatter.dart';

class DetailController {
  DetailController(this._currency);

  final RateData _currency;

  String get code => _currency.code;

  String get name => _currency.name;

  double get rate => _currency.rate;

  DateTime get date => _currency.date;

  int get scale => _currency.scale;

  String get formattedDate =>
      toDayMonthYearTextDateFormat(date) ?? 'Дата отсутствует';

  String calculate(double amount) {
    return (amount * _currency.scale / _currency.rate).toStringAsFixed(2);
  }

  String calculateReverse(double amount) {
    return (amount * _currency.rate / _currency.scale).toStringAsFixed(2);
  }
}
