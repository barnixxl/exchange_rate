import '../../models/rate_data.dart';

class DetailController {
  DetailController(this._currency);

  final RateData _currency;

  String get code => _currency.code;

  String get name => _currency.name;

  double get rate => _currency.rate;

  DateTime get date => _currency.date;

  int get scale => _currency.scale;

  String formatDate() {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String calculate(double amount) {
    return (amount / _currency.rate).toStringAsFixed(2);
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
