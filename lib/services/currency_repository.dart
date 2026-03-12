import '../models/currency_model.dart';
import '../net/currency/api.dart';

class CurrencyRepository {
  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<List<CurrencyModel>> fetchRates(String baseCurrency) async {
    final apiResponse = await _api.fetchRates(baseCurrency);

    final currencies = <CurrencyModel>[];

    for (final code in CurrencyModel.supportedCurrencies) {
      currencies.add(CurrencyModel.fromResponse(apiResponse, code));
    }

    currencies.sort((a, b) => a.code.compareTo(b.code));

    return currencies;
  }
}
