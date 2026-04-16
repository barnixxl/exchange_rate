import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static const _targerCurrencies = ["USD", "EUR", "CNY", "PLN", "UAH"];

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();
    if(result.isSuccess) {
      final filtered = result.data!
          .where((r) => _targerCurrencies.contains(r.code))
          .toList()
          ..sort((a, b){
            final indexA = _targerCurrencies.indexOf(a.code);
            final indexB = _targerCurrencies.indexOf(b.code);
            return indexA.compareTo(indexB);
          });
      return CurrencyResult.success(filtered);
    }
    return result;
  }
}
