import 'package:currency_converter/models/currency_error.dart';

import '../network/currency/resp/rate_data_from_network.dart';

class RateData {
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

  RateData({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
  });

  factory RateData.fromRateData(RateDataFromNetwork rateData) {
    final code = rateData.curAbbreviation ?? '';
    final name = rateData.curName ?? 'Неизвестное название валюты';
    final scale = rateData.curScale ?? 1;
    final officialRate = rateData.curOfficialRate ?? 0.0;
    final dateStr = rateData.date ?? DateTime.now().toIso8601String();
    return RateData(
      code: code,
      name: name,
      rate: officialRate / scale,
      date: DateTime.parse(dateStr),
    );
  }

  static RateData fromResponse(List<RateDataFromNetwork> rates, String code) {
    final rateData = rates.firstWhere((r) => r.curAbbreviation == code,
        orElse: () => throw CurrencyError(
            code: 'CURRENCY_NOT_FOUND', message: 'Валюта $code не найдена'));
    return RateData.fromRateData(rateData);
  }

  factory RateData.fromJson(Map<String, dynamic> json) {
    return RateData(
      code: json['code'] ?? '',
      name: json['name'] ?? 'данная валюта отсутствует',
      rate: (json['rate'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  static RateData withRecalculatedRate(
    RateData model,
    String newBaseCurrency,
    Map<String, double> rates,
  ) {
    final baseRate = rates[newBaseCurrency] ?? 1.0;
    final newRate = model.code == newBaseCurrency ? 1.0 : model.rate / baseRate;

    return RateData(
      code: model.code,
      name: model.name,
      rate: double.parse(newRate.toStringAsFixed(6)),
      date: model.date,
    );
  }

  static List<RateData> fromNetworkList(List<RateDataFromNetwork> rates) {
    final currencies = <RateData>[];
    for(final code in supportedCurrencies) {
      final rateData = rates.firstWhere(
          (r) => r.curAbbreviation == code,
        orElse: () => throw CurrencyError(code: 'CURRENCY_NOT_FOUND', message: 'Валюта $code не найдена',
      ),
      );
      currencies.add(RateData.fromRateData(rateData));
    }
    currencies.sort((a,b) => a.code.compareTo(b.code));
    return currencies;
  }

  @override
  String toString() {
    return 'CurrencyModel(code: $code, name: $name, rate: $rate)';
  }
}
