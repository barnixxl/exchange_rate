// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resp_currency_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateData _$RateDataFromJson(Map<String, dynamic> json) => RateData(
      cur_ID: (json['Cur_ID'] as num).toInt(),
      cur_Abbreviation: json['Cur_Abbreviation'] as String,
      cur_Scale: (json['Cur_Scale'] as num).toInt(),
      cur_Name: json['Cur_Name'] as String,
      cur_OfficialRate: (json['Cur_OfficialRate'] as num).toDouble(),
      date: json['Date'] as String,
    );

Map<String, dynamic> _$RateDataToJson(RateData instance) => <String, dynamic>{
      'Cur_ID': instance.cur_ID,
      'Cur_Abbreviation': instance.cur_Abbreviation,
      'Cur_Scale': instance.cur_Scale,
      'Cur_Name': instance.cur_Name,
      'Cur_OfficialRate': instance.cur_OfficialRate,
      'Date': instance.date,
    };
