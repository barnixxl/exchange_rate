import 'package:json_annotation/json_annotation.dart';

part 'resp_currency_from_network.g.dart';

@JsonSerializable()
class RespCurrencyFromNetwork {
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

  RespCurrencyFromNetwork({
    required this.cur_ID,
    required this.cur_Abbreviation,
    required this.cur_Scale,
    required this.cur_Name,
    required this.cur_OfficialRate,
    required this.date,
  });

  factory RespCurrencyFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$RateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RateDataToJson(this);
}
