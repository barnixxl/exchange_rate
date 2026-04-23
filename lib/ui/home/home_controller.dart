import 'package:mobx/mobx.dart';
import '../../models/rate_data.dart';
import '../../models/currency_result.dart';
import '../../services/currency_repository.dart';

class HomeController {
  HomeController(this._repository);

  final CurrencyRepository _repository;

  late final Observable<CurrencyResult<List<RateData>>> currencyResult =
      Observable(CurrencyResult.notInitialized());

  List<RateData> _extractCurrencies(CurrencyResult<List<RateData>> result) {
    if (result.isSuccess) {
      return result.data ?? [];
    }
    return [];
  }

  late final Computed<List<RateData>> currencies = Computed(() {
    return _extractCurrencies(currencyResult.value);
  });

  DateTime? _extractLastUpdateDate(CurrencyResult<List<RateData>> result) {
    if (result.status == Status.notInitialized) return null;
    if (result.isError) return null;
    if (result.isLoading) return null;
    final data = result.data;
    if (data == null || data.isEmpty) return null;
    return data.first.date;
  }

  late final Computed<DateTime?> lastUpdateDate = Computed(() {
    return _extractLastUpdateDate(currencyResult.value);
  });

  Future<void> loadCurrencies() async {
    runInAction(() {
      currencyResult.value = CurrencyResult.loading();
    });
    final result = await _repository.fetchRates();
    runInAction(() {
      currencyResult.value = result;
    });
  }
}
