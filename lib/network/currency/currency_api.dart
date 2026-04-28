import 'package:currency_converter/models/rate_data.dart';
import 'package:get_it/get_it.dart';
import '../currency_rate_network.dart';
import '../../models/currency_error.dart';
import 'resp/rate_data_from_network.dart';
import '../../models/currency_result.dart';

class CurrencyApi {
  static final GetIt _getIt = GetIt.instance;
  final CurrencyRateNetwork _network;

  CurrencyApi(this._network);

  static void register() {
    CurrencyRateNetwork.register();
    if (!_getIt.isRegistered<CurrencyApi>()) {
      _getIt.registerLazySingleton<CurrencyApi>(
        () => CurrencyApi(_getIt<CurrencyRateNetwork>()),
      );
    }
  }

  static CurrencyApi getInstance() {
    if(_getIt.isRegistered<CurrencyApi>()){
      register(); 
    }
    return _getIt<CurrencyApi>();
  }

  Future<CurrencyResult<List<RateData>>> fetchRates() async {
    const url = '/rates?periodicity=0';
    try {
      final result = await _network.get(url);
      if (result.error == null) {
        final networkRates = (result.data as List<dynamic>)
            .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
            .toList();
        final rates =
            networkRates.map((e) => RateData.fromNetworkModel(e)).toList();
        return CurrencyResult.success(rates);
      } else {
        return CurrencyResult.failure(result.error);
      }
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
