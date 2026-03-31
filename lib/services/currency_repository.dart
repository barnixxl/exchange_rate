import '../models/rate_data.dart';
import '../network/currency/currency_api.dart';
import '../models/currency_error.dart';

class CurrencyRepository {
  final CurrencyApi _api;
  List<RateData>? _cachedRates;

  CurrencyRepository(this._api);

  Future<List<RateData>> fetchRates() async {
    final currencies = await _api.fetchRates();
    _cachedRates = currencies;
    return currencies;
  }

  bool hasCachedRates() => _cachedRates != null;

  Map<String, double> getCachedRatesMap() {
    if (_cachedRates == null) {
      throw CurrencyError.noData();
    }
    return {for (var c in _cachedRates!) c.code: c.rate};
  }

  List<RateData> recalculateToBaseCurrency(String newBaseCurrency) {
    if (_cachedRates == null) {
      throw CurrencyError.noData();
    }

    final ratesMap = getCachedRatesMap();

    return _cachedRates!.map((currency) {
      return RateData.withRecalculatedRate(
        currency,
        newBaseCurrency,
        ratesMap,
      );
    }).toList();
  }
}
