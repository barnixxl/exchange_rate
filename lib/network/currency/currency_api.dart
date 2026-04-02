import '../currency_rate_network.dart';
import '../../models/currency_error.dart';
import 'resp/rate_data_from_network.dart';
import '../../models/currency_result.dart';

class CurrencyApi {
  final CurrencyRateNetwork _network;

  CurrencyApi(this._network);

  Future<CurrencyResult<List<RateDataFromNetwork>>> fetchRates() async {
    const url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>?;
      if (data != null) {
        final rates = data
            .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
            .toList();
        return CurrencyResult.success(rates);
      }
    }

    if (response.statusCode != 200) {
      return CurrencyResult.failure(CurrencyError.loadFailed());
    }

    return CurrencyResult.failure(CurrencyError.parsing());
  }
}