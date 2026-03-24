import '../exchange_rate_network.dart';
import 'resp/resp_currency_from_network.dart';

class CurrencyApi {
  final ExchangeRateNetwork _network;

  CurrencyApi(this._network);

  Future<List<RespCurrencyFromNetwork>> fetchRates() async {
    final url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data
          .map((e) => RespCurrencyFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  }
}
