import 'package:json_annotation/json_annotation.dart';

part 'resp_currency_from_network.g.dart';

@JsonSerializable()
class CurrencyApiResponse {
  final String date;
  final List<RateData> rates;

  CurrencyApiResponse({
    required this.date,
    required this.rates,
  });

  factory CurrencyApiResponse.fromJson(dynamic json) {
    if (json is List) {
      final ratesList = json
          .map((e) => RateData.fromJson(e as Map<String, dynamic>))
          .toList();

      final dateStr = ratesList.isNotEmpty ? ratesList.first.date : null;

      return CurrencyApiResponse(
        date: dateStr ?? DateTime.now().toIso8601String(),
        rates: ratesList,
      );
    }

    final data = json['rates'] ?? json;
    final ratesList = (data is List ? data : [data])
        .map((e) => RateData.fromJson(e as Map<String, dynamic>))
        .toList();

    String dateStr = json['Date'];
    if (dateStr == null && ratesList.isNotEmpty) {
      dateStr = ratesList.first.date;
    }

    return CurrencyApiResponse(
      date: dateStr ?? DateTime.now().toIso8601String(),
      rates: ratesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'rates': rates.map((e) => e.toJson()).toList(),
      };
}

@JsonSerializable()
class RateData {
  @JsonKey(name: 'Cur_ID')
  final int cur_ID;
  @JsonKey(name: 'Cur_Abbreviation')
  final String cur_Abbreviation;
  @JsonKey(name: 'Cur_Scale')
  final int cur_Scale;
  @JsonKey(name: 'Cur_Name')
  final String cur_Name;
  @JsonKey(name: 'Cur_OfficialRate')
  final double cur_OfficialRate;
  @JsonKey(name: 'Date')
  final String date;

  RateData({
    required this.cur_ID,
    required this.cur_Abbreviation,
    required this.cur_Scale,
    required this.cur_Name,
    required this.cur_OfficialRate,
    required this.date,
  });

  factory RateData.fromJson(Map<String, dynamic> json) =>
      _$RateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RateDataToJson(this);
}
