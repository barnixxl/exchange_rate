import 'package:json_annotation/json_annotation.dart';

part 'get_currency_req_data.g.dart';

@JsonSerializable()
class FetchRatesRequest {
  final String baseCurrency;

  FetchRatesRequest({required this.baseCurrency});

  String get url => '/$baseCurrency';

  factory FetchRatesRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchRatesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FetchRatesRequestToJson(this);
}
