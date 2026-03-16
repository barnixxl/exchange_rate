import '../models/currency_model.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  final CurrencyApi _api;
  List<CurrencyModel>? _cachedRates;

  CurrencyRepository(this._api);

  Future<List<CurrencyModel>> fetchRates() async {
    final apiResponse = await _api.fetchRates();

    final currencies = <CurrencyModel>[];

    for (final code in CurrencyModel.supportedCurrencies) {
      currencies.add(CurrencyModel.fromResponse(apiResponse, code));
    }

    currencies.sort((a, b) => a.code.compareTo(b.code));

    _cachedRates = currencies;

    return currencies;
  }

  bool hasCachedRates() => _cachedRates != null;

  Map<String, double> getCachedRatesMap() {
    if (_cachedRates == null) {
      throw Exception('Нет закэшированных данных');
    }
    return {for (var c in _cachedRates!) c.code: c.rate};
  }

  List<CurrencyModel> recalculateToBaseCurrency(String newBaseCurrency) {
    if (_cachedRates == null) {
      throw Exception('Нет закэшированных данных');
    }

    final ratesMap = getCachedRatesMap();

    return _cachedRates!.map((currency) {
      return CurrencyModel.withRecalculatedRate(
        currency,
        newBaseCurrency,
        ratesMap,
      );
    }).toList();
  }
}
