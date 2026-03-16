// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resp_currency_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyApiResponse _$CurrencyApiResponseFromJson(Map<String, dynamic> json) =>
    CurrencyApiResponse(
      date: json['date'] as String,
      rates: json['rates'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CurrencyApiResponseToJson(
        CurrencyApiResponse instance) =>
    <String, dynamic>{
      'date': instance.date,
      'rates': instance.rates,
    };
