import '../models/currency_error.dart';
import '../models/rate_data.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static const _targetCurrencies = ["USD", "EUR", "CNY", "PLN", "UAH"];

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<(List<RateData>?, CurrencyError?)> fetchRates() async {
    final result = await _api.fetchRates();
    if (!result.isSuccess) {
      return (null, result.error);
    }
    return (_filterAndSortRates(result.data), null);
  }

  List<RateData> _filterAndSortRates(List<RateData>? rates) {
    if (rates != null) {
      final filtered =
          rates.where((r) => _targetCurrencies.contains(r.code)).toList();

      filtered.sort((a, b) {
        final indexA = _targetCurrencies.indexOf(a.code);
        final indexB = _targetCurrencies.indexOf(b.code);
        return indexA.compareTo(indexB);
      });
      return filtered;
    }
    return [];
  }
}
