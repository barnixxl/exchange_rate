import 'package:mobx/mobx.dart';
import '../../models/rate_data.dart';
import '../../models/currency_result.dart';
import '../../services/currency_repository.dart';

class HomeController {
  HomeController(this._repository);

  final CurrencyRepository _repository;

  late final Observable<CurrencyResult<List<RateData>>> currencyResult =
      Observable(CurrencyResult.notInitialized());

  List<RateData> get currencies => currencyResult.value.status == Status.success
      ? currencyResult.value.data ?? []
      : [];

  late final Computed<DateTime?> lastUpdateDate = Computed(() {
    final result = currencyResult.value;
    if (result.status == Status.notInitialized) return null;
    if (result.isError) return null;
    if (result.isLoading) return null;
    final data = result.data;
    if (data == null || data.isEmpty) return null;
    return data.first.date;
  });

  Future<void> loadCurrencies() async {
    runInAction(() {
      currencyResult.value = CurrencyResult.loading();
    });
    final (rates, error) = await _repository.fetchRates();
    runInAction(() {
      if (error != null) {
        currencyResult.value = CurrencyResult.failure(error);
      } else {
        currencyResult.value = CurrencyResult.success(rates ?? []);
      }
    });
  }
}
