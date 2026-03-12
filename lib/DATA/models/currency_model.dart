import '../response/currency_response.dart';

class CurrencyModel {
  final String code;
  final String name;
  final double rate;
  final DateTime date;

  static const List<String> supportedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'CNY',
    'JPY',
  ];

  static const Map<String, String> _currencyNames = {
    'USD': 'Доллар США',
    'EUR': 'Евро',
    'GBP': 'Фунт стерлингов',
    'JPY': 'Японская иена',
    'CNY': 'Китайский юань',
  };

  CurrencyModel({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
  });

  factory CurrencyModel.fromResponse(
      CurrencyApiResponse response, String code) {
    final rate = response.rates[code]?.toDouble() ?? 0.0;
    return CurrencyModel(
      code: code,
      name: _currencyNames[code] ?? code,
      rate: rate,
      date: DateTime.parse(response.date),
    );
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code'] ?? '',
      name: json['name'] ?? 'данная валюта отсутствует',
      rate: (json['rate'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  String toString() {
    return 'CurrencyModel(code: $code, name: $name, rate: $rate)';
  }
}
