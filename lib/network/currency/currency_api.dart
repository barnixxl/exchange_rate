import '../../models/rate_data.dart';
import '../exchange_rate_network.dart';
import 'resp/rate_currency_from_network.dart';

class CurrencyApi {
  final ExchangeRateNetwork _network;

  CurrencyApi(this._network);

  Future<List<RateData>> fetchRates() async {
    final url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List;
      final rates = data
          .map((e) =>
          RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList();

      final currencies = <RateData>[];
      for (final code in RateData.supportedCurrencies) {
        currencies.add(RateData.fromResponse(rates, code));
      }
      currencies.sort((a, b) => a.code.compareTo(b.code));
      return currencies;
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  }
}
