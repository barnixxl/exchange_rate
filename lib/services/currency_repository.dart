import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  final CurrencyApi _api;
  List<RateData>? _cachedRates;

  static const List<String> supportedCurrencies = [
    'RUB',
    'USD',
    'EUR',
    'GBP',
    'CNY',
    'JPY',
  ];

  RateData recalculateRate(
      RateData model, String newBaseCurrency, Map<String, double> rates) {
    final baseRate = rates[newBaseCurrency] ?? 1.0;
    final newRate = model.code == newBaseCurrency ? 1.0 : model.rate / baseRate;
    return RateData(
      code: model.code,
      name: model.name,
      rate: double.parse(newRate.toStringAsFixed(6)),
      date: model.date,
    );
  }

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();
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
      return recalculateRate(
        currency,
        newBaseCurrency,
        ratesMap,
      );
    }).toList();
  }
}
