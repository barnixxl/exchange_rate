import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static const _targetCurrencies = ["USD", "EUR", "CNY", "PLN", "UAH"];

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();

    if (result.isSuccess) {
      _filterAndSortRates(result.data);
    }
    return result;
  }

  void _filterAndSortRates(List<RateData>? rates) {
    if (rates == null) return;
    rates
      ..retainWhere((rate) => _targetCurrencies.contains(rate.code))
      ..sort((a, b) {
        final indexA = _targetCurrencies.indexOf(a.code);
        final indexB = _targetCurrencies.indexOf(b.code);
        return indexA.compareTo(indexB);
      });
  }
}
