import '../currency_rate_network.dart';
import '../../models/currency_error.dart';
import 'resp/rate_data_from_network.dart';
import '../../models/currency_result.dart';

class CurrencyApi {
  final CurrencyRateNetwork _network;

  CurrencyApi(this._network);

  Future<CurrencyResult<List<RateDataFromNetwork>>> fetchRates() async {
    const url = '/rates?periodicity=0';

    try {
      final result = await _network.get(url);
      if (result.error == null) {
        final rates = (result.rates as List<dynamic>)
            .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
            .toList();
        return CurrencyResult.success(rates);
      } else {
        return CurrencyResult.failure(result.error);
      }
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
