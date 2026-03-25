import 'package:json_annotation/json_annotation.dart';

part 'rate_currency_from_network.g.dart';

@JsonSerializable(createToJson: false)
class RateDataFromNetwork {
  @JsonKey(name: 'Cur_ID')
  final int? curID;
  @JsonKey(name: 'Cur_Abbreviation')
  final String? curAbbreviation;
  @JsonKey(name: 'Cur_Scale')
  final int? curScale;
  @JsonKey(name: 'Cur_Name')
  final String? curName;
  @JsonKey(name: 'Cur_OfficialRate')
  final double? curOfficialRate;
  @JsonKey(name: 'Date')
  final String? date;

  RateDataFromNetwork({
    required this.curID,
    required this.curAbbreviation,
    required this.curScale,
    required this.curName,
    required this.curOfficialRate,
    required this.date,
  });

  factory RateDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$RateDataFromJson(json);

  Map<String, dynamic> toJson() => _$RateDataToJson(this);

  @override
  String toString() => 'RateDataFromNetwork('
      'curID: $curID, '
      'curAbbreviation: $curAbbreviation, '
      'curScale: $curScale, '
      'curName: $curName, '
      'curOfficialRate: $curOfficialRate, '
      'date: $date'
      ')';
}
