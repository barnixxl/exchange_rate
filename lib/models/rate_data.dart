import '../network/currency/resp/rate_data_from_network.dart';

class RateData {
  final String code;
  final String name;
  final double rate;
  final DateTime date;
  final int scale;

  RateData({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
    required this.scale,
  });

  static RateData fromNetworkModel(RateDataFromNetwork model) {
    print(
        'curOfficialRate: ${model.curOfficialRate}, curScale: ${model.curScale}');
    return RateData(
      code: model.curAbbreviation ?? '',
      name: model.curName ?? 'Неизвестное название валюты',
      rate: model.curOfficialRate ?? 0.0,
      scale: model.curScale ?? 1,
      //scale: (model.curScale ?? 1).toInt(),
      //rate: (model.curOfficialRate ?? 0.0) / (model.curScale ?? 1),
      date: DateTime.parse(model.date ?? DateTime.now().toIso8601String()),
    );
  }
}
