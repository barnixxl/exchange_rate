import '../exchange_rate_network.dart';
import 'resp/resp_currency_from_network.dart';

class CurrencyApi {
  final Network _network;

  CurrencyApi(this._network);

  Future<CurrencyApiResponse> fetchRates() async {
    final url = '/rates?periodicity=0';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      return CurrencyApiResponse.fromJson(response.data);
    } else {
      throw Exception('Error loading rates: ${response.statusCode}');
    }
  }
}
