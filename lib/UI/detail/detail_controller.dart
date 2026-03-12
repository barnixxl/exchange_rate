import 'package:mobx/mobx.dart';
import '../../DATA/models/currency_model.dart';

class DetailController {
  DetailController(this._currency);

  final CurrencyModel _currency;

  String get code => _currency.code;
  String get name => _currency.name;
  double get rate => _currency.rate;
  DateTime get date => _currency.date;

  String formatDate() {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String calculate(int amount) {
    return (amount * _currency.rate).toStringAsFixed(2);
  }

  String _getMonthName(int month) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return months[month - 1];
  }
}
