import '../models/rate_data.dart';
import '../models/currency_error.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static const _targetCurrencies = ["USD", "EUR", "CNY", "PLN", "UAH"];

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();

    if (result.isSuccess) {
      return _handleSuccess(result.data);
    }
    return _handleFailure(result.error);
  }

  CurrencyResult<List<RateData>> _handleSuccess(List<RateData>? rates) {
    if (rates == null) {
      return CurrencyResult.failure(CurrencyError.noData());
    }
    final prepared = _filterAndSortRates(rates);
    return CurrencyResult.success(prepared);
  }

  CurrencyResult<List<RateData>> _handleFailure(CurrencyError? error) {
    return CurrencyResult.failure(error ?? CurrencyError.loadFailed());
  }

  List<RateData> _filterAndSortRates(List<RateData> rates) {
    final filtered =
        rates.where((r) => _targetCurrencies.contains(r.code)).toList()
          ..sort((a, b) {
            final indexA = _targetCurrencies.indexOf(a.code);
            final indexB = _targetCurrencies.indexOf(b.code);
            return indexA.compareTo(indexB);
          });
    return filtered;
  }
}
