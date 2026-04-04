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
      final List<dynamic>? ratesData = await _network.get(url);

      if (ratesData != null) {
        final rates = ratesData
            .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
            .toList();
        return CurrencyResult.success(rates);
      }
      return CurrencyResult.failure(CurrencyError.parsing());
    } catch (e) {
      if (e is CurrencyError) {
        return CurrencyResult.failure(e);
      }
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
