import 'package:mobx/mobx.dart';

import '../../models/currency_result.dart';
import '../../models/rate_data.dart';
import '../../services/currency_repository.dart';

class HomeController {
  final CurrencyRepository _repository = CurrencyRepository.getInstance();

  final Observable<CurrencyResult<List<RateData>>> currencyResult = Observable(
    CurrencyResult.notInitialized(),
  );

  bool get isLoading => currencyResult.value.isLoading;

  bool get hasError => currencyResult.value.isError;

  bool get hasSuccess => currencyResult.value.isSuccess;

  List<RateData> get currencies {
    final result = currencyResult.value;
    if (!result.isSuccess) {
      return [];
    }
    return result.data ?? [];
  }

  DateTime? get lastUpdateDate {
    final data = currencies;
    if (data.isEmpty) {
      return null;
    }
    return data.first.date;
  }

  Future<void> loadCurrencies() async {
    _updateCurrencyResult(
      CurrencyResult.loading(),
    );
    final result = await _repository.fetchRates();
    _updateCurrencyResult(result);
  }

  void _updateCurrencyResult(
    CurrencyResult<List<RateData>> result,
  ) {
    runInAction(() {
      currencyResult.value = result;
    });
  }
}
