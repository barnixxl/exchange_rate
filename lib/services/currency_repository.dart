import 'package:currency_converter/network/currency_rate_network.dart';
import 'package:get_it/get_it.dart';
import '../models/rate_data.dart';
import '../models/currency_result.dart';
import '../network/currency/currency_api.dart';

class CurrencyRepository {
  static void initDependencies() {
    GetIt.I.registerSingleton<CurrencyRateNetwork>(CurrencyRateNetwork());
    GetIt.I.registerSingleton<CurrencyApi>(
        CurrencyApi(GetIt.I<CurrencyRateNetwork>()));
    GetIt.I.registerSingleton<CurrencyRepository>(
        CurrencyRepository(GetIt.I<CurrencyApi>()));
  }

  final CurrencyApi _api;

  CurrencyRepository(this._api);

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    final result = await _api.fetchRates();
    return result;
  }
}
