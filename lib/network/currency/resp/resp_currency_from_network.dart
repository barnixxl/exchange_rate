import 'package:json_annotation/json_annotation.dart';

part 'resp_currency_from_network.g.dart';

@JsonSerializable()
class CurrencyApiResponse {
  final String date;
  final Map<String, dynamic> rates;

  CurrencyApiResponse({
    required this.date,
    required this.rates,
  });

  factory CurrencyApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyApiResponseToJson(this);
}
