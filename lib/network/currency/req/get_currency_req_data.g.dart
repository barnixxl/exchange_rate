// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_currency_req_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchRatesRequest _$FetchRatesRequestFromJson(Map<String, dynamic> json) =>
    FetchRatesRequest(
      baseCurrency: json['baseCurrency'] as String,
    );

Map<String, dynamic> _$FetchRatesRequestToJson(FetchRatesRequest instance) =>
    <String, dynamic>{
      'baseCurrency': instance.baseCurrency,
    };
