import 'package:json_annotation/json_annotation.dart';

part 'resp_currency_from_network.g.dart';

@JsonSerializable()
class RespCurrencyFromNetwork {
  @JsonKey(name: 'CurID')
  final int? curID;
  @JsonKey(name: 'CurAbbreviation')
  final String? curAbbreviation;
  @JsonKey(name: 'CurScale')
  final int? curScale;
  @JsonKey(name: 'CurName')
  final String? curName;
  @JsonKey(name: 'CurOfficialRate')
  final double? curOfficialRate;
  @JsonKey(name: 'Date')
  final String? date;

  RespCurrencyFromNetwork({
    required this.curID,
    required this.curAbbreviation,
    required this.curScale,
    required this.curName,
    required this.curOfficialRate,
    required this.date,
  });

  factory RespCurrencyFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$RateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RateDataToJson(this);

  @override
  String toString() => 'RespCurrencyFromNetwork('
      'curID: $curID, '
      'curAbbreviation: $curAbbreviation, '
      'curScale: $curScale, '
      'curName: $curName, '
      'curOfficialRate: $curOfficialRate, '
      'date: $date'
      ')';
}
