import 'package:get_it/get_it.dart';
import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';
import '../repository/base_repository.dart';

class CurrencyRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;
  static const _targetCurrencies = [
    "USD",
    "EUR",
    "CNY",
    "PLN",
    "UAH",
  ];

  late final CurrencyApi _api;

  @override
  void register(GetIt getIt) {
    getIt.registerSingleton<CurrencyRepository>(this);
  }

  @override
  Future<void> initializeDependencies() async {
    _api = _getIt<CurrencyApi>();
  }

  static CurrencyRepository getInstance() {
    return _getIt<CurrencyRepository>();
  }

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();
    if (result.isError) {
      return result;
    }
    return CurrencyResult.success(
      _filterAndSortRates(result.data),
    );
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