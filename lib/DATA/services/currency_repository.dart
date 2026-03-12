import '../models/currency_model.dart';
import 'currency_request.dart';
import 'currency_response.dart';
import 'network.dart';

class CurrencyRepository {
  final Network _network;

  CurrencyRepository(this._network);

  Future<List<CurrencyModel>> fetchRates(String baseCurrency) async {
    final request = FetchRatesRequest(baseCurrency: baseCurrency);
    final response = await _network.get(request.url);

    if (response.statusCode == 200) {
      final apiResponse = CurrencyApiResponse.fromJson(response.data);

      final currencies = <CurrencyModel>[];

      for (final code in CurrencyModel.supportedCurrencies) {
        currencies.add(CurrencyModel.fromResponse(apiResponse, code));
      }

      currencies.sort((a, b) => a.code.compareTo(b.code));

      return currencies;
    } else {
      throw Exception('Error loading rates: ${response.statusCode}');
    }
  }
}
