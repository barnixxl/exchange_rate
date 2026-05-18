import 'package:get_it/get_it.dart';
import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';
import '../repository/base_repository.dart';
import '../resources/images/app_images.dart';

enum CurrencyAssets { usd, eur, cny, pln, uah }

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
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<CurrencyRepository>(
      this,
    );
  }

  @override
  Future<void> initializeDependencies() async {
    _api = _getIt<CurrencyApi>();
  }

  static String imagesAssetsFor(
      String code,
      ) {
    final abbreviation = switch (code) {
      'USD' => CurrencyAssets.usd,
      'EUR' => CurrencyAssets.eur,
      'CNY' => CurrencyAssets.cny,
      'PLN' => CurrencyAssets.pln,
      'UAH' => CurrencyAssets.uah,
      _ => CurrencyAssets.usd,
    };

    return switch (abbreviation) {
      CurrencyAssets.usd => AppImages.usd,
      CurrencyAssets.eur => AppImages.eur,
      CurrencyAssets.cny => AppImages.cny,
      CurrencyAssets.pln => AppImages.pln,
      CurrencyAssets.uah => AppImages.uah,
    };
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
      _filterAndSortRates(
        result.data,
      ),
    );
  }

  List<RateData> _filterAndSortRates(List<RateData>? rates) {
    if (rates != null) {
      final filtered =
          rates.where((r) => _targetCurrencies.contains(r.code)).toList();
      filtered.sort((a, b) {
        final indexA = _targetCurrencies.indexOf(a.code);
        final indexB = _targetCurrencies.indexOf(b.code);
        return indexA.compareTo(
          indexB,
        );
      });
      return filtered;
    }
    return [];
  }
}
