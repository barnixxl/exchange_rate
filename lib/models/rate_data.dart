import 'package:currency_converter/models/currency_error.dart';

import '../network/currency/resp/rate_data_from_network.dart';

class RateData {
  final String code;
  final String name;
  final double rate;
  final DateTime date;

  RateData({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
  });

  static RateData fromResponse(List<RateDataFromNetwork> rates, String code) {
    final rateData = rates.firstWhere((r) => r.curAbbreviation == code,
        orElse: () => throw CurrencyError(
            code: 'CURRENCY_NOT_FOUND', message: 'Валюта $code не найдена'));
    return RateData.fromNetworkModel(rateData);
  }

  factory RateData.fromJson(Map<String, dynamic> json) {
    return RateData(
      code: json['code'] ?? '',
      name: json['name'] ?? 'данная валюта отсутствует',
      rate: (json['rate'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  static RateData fromNetworkModel(RateDataFromNetwork model) {
    return RateData(
      code: model.curAbbreviation ?? '',
      name: model.curName ?? 'Неизвестное название валюты',
      rate: (model.curOfficialRate ?? 0.0) / (model.curScale ?? 1),
      date: DateTime.parse(model.date ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  String toString() {
    return 'CurrencyModel(code: $code, name: $name, rate: $rate)';
  }
}
