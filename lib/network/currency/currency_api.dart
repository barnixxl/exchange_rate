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

      if (result.isError) {
        return CurrencyResult.failure(result.error!);
      }
      final data = result.rates as List<dynamic>?;
      if (data == null) {
        return CurrencyResult.failure(CurrencyError.parsing());
      }
      final rates = data
          .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList();
      return CurrencyResult.success(rates);
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
