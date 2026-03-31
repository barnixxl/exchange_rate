import '../currency_rate_network.dart';
import '../../models/currency_error.dart';
import 'resp/rate_data_from_network.dart';

class CurrencyApi {
  final CurrencyRateNetwork _network;

  CurrencyApi(this._network);

  Future<List<RateDataFromNetwork>> fetchRates() async {
    const url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      final data = response.data;
      if (data is! List) throw CurrencyError.parsing();
      return data
          .map((e) => RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw CurrencyError.loadFailed();
    }
  }
}
