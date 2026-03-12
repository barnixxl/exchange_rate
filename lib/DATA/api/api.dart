import '../network/network.dart';
import '../response/currency_response.dart';

class CurrencyApi {
  final Network _network;

  CurrencyApi(this._network);

  Future<CurrencyApiResponse> fetchRates(String baseCurrency) async {
    final url = '/$baseCurrency';
    final response = await _network.get(url);

    if (response.statusCode == 200) {
      return CurrencyApiResponse.fromJson(response.data);
    } else {
      throw Exception('Error loading rates: ${response.statusCode}');
    }
  }
}
