import '../../models/currency_model.dart';
import '../exchange_rate_network.dart';
import 'resp/resp_currency_from_network.dart';

class CurrencyApi {
  final ExchangeRateNetwork _network;

  CurrencyApi(this._network);

  Future<List<CurrencyModel>> fetchRates() async {
    final url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List;
      final rates = data
          .map((e) =>
              RespCurrencyFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList();

      final currencies = <CurrencyModel>[];
      for (final code in CurrencyModel.supportedCurrencies) {
        currencies.add(CurrencyModel.fromResponse(rates, code));
      }
      currencies.sort((a, b) => a.code.compareTo(b.code));
      return currencies;
    } else {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }
  }
}
