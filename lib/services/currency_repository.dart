import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  final CurrencyApi _api;
  List<RateData>? _cachedRates;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();

    if (result.isError) {
      return CurrencyResult.failure(result.error!);
    }

    _cachedRates =  result.rates!;
    return result;
  }

  bool hasCachedRates() => _cachedRates != null;

  Map<String, double> getCachedRatesMap() {
    if (_cachedRates == null) {
      throw Exception('Нет закэшированных данных');
    }
    return {for (var c in _cachedRates!) c.code: c.rate};
  }

  List<RateData> recalculateToBaseCurrency(String newBaseCurrency) {
    if (_cachedRates == null) {
      throw Exception('Нет закэшированных данных');
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
