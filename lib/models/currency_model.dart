import '../network/currency/resp/resp_currency_from_network.dart';

class CurrencyModel {
  final String code;
  final String name;
  final double rate;
  final DateTime date;

  static const List<String> supportedCurrencies = [
    'RUB',
    'USD',
    'EUR',
    'GBP',
    'CNY',
    'JPY',
  ];

  CurrencyModel({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
  });

  factory CurrencyModel.fromRateData(RateData rateData) {
    final rate = rateData.cur_OfficialRate / rateData.cur_Scale;

    return CurrencyModel(
      code: rateData.cur_Abbreviation,
      name: rateData.cur_Name,
      rate: rate,
      date: DateTime.parse(rateData.date),
    );
  }

  static CurrencyModel fromResponse(List<RateData> rates, String code) {
    final rateData = rates.firstWhere(
      (r) => r.cur_Abbreviation == code,
      orElse: () => throw Exception('Currency $code not found'),
    );
    return CurrencyModel.fromRateData(rateData);
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code'] ?? '',
      name: json['name'] ?? 'данная валюта отсутствует',
      rate: (json['rate'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  static CurrencyModel withRecalculatedRate(
    CurrencyModel model,
    String newBaseCurrency,
    Map<String, double> rates,
  ) {
    final baseRate = rates[newBaseCurrency] ?? 1.0;
    final newRate = model.code == newBaseCurrency ? 1.0 : model.rate / baseRate;

    return CurrencyModel(
      code: model.code,
      name: model.name,
      rate: double.parse(newRate.toStringAsFixed(6)),
      date: model.date,
    );
  }

  @override
  String toString() {
    return 'CurrencyModel(code: $code, name: $name, rate: $rate)';
  }
}
