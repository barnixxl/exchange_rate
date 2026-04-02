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
      final response = await _network.get(url);

      if (response.statusCode == 200) {
        final List<dynamic>? ratesData = response.data;
        if (ratesData != null) {
          final rates = ratesData
              .map((e) =>
              RateDataFromNetwork.fromJson(e as Map<String, dynamic>))
              .toList();
          return CurrencyResult.success(rates);
        }
      } else {
        return CurrencyResult.failure(
          CurrencyError(
            code: 'LOAD_FAILED',
            message: response.statusMessage ?? 'Ошибка загрузки',
          ),
        );
      }
      return CurrencyResult.failure(CurrencyError.parsing());
    } catch (e) {
      return CurrencyResult.failure(CurrencyError.fromException(e));
    }
  }
}
