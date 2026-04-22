import '../models/rate_data.dart';
import '../models/currency_error.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static const _targetCurrencies = ["USD", "EUR", "CNY", "PLN", "UAH"];

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final apiResult = await _api.fetchRates();
    if (apiResult.isSuccess) {
      final rates = apiResult.data;
      if (rates == null) {
        return CurrencyResult.failure(CurrencyError.noData());
      }
      final prepared = _filterAndSortRates(rates);
      return CurrencyResult.success(prepared);
    }
    if (apiResult.isError) {
      return CurrencyResult.failure(
        apiResult.error ?? CurrencyError.loadFailed(),
      );
    }
    return CurrencyResult.failure(CurrencyError.loadFailed());
  }

  List<RateData> _filterAndSortRates(List<RateData> rates) {
    final filtered =
        rates.where((rate) => _targetCurrencies.contains(rate.code)).toList();
    filtered.sort((a, b) {
      final indexA = _targetCurrencies.indexOf(a.code);
      final indexB = _targetCurrencies.indexOf(b.code);
      return indexA.compareTo(indexB);
    });
    return filtered;
  }
}
