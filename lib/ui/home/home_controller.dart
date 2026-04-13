import 'package:mobx/mobx.dart';
import '../../models/rate_data.dart';
import '../../models/currency_result.dart';
import '../../services/currency_repository.dart';
import '../../utils/date_formatter.dart';

class HomeController {
  HomeController(this._repository);

  final CurrencyRepository _repository;

  late final Observable<CurrencyResult<List<RateData>>> currencyResult =
      Observable(CurrencyResult.notInitialized());

  List<RateData> get currencies => currencyResult.value.status == Status.success
      ? currencyResult.value.rates ?? []
      : [];

  late final Computed<String> lastUpdateDate = Computed(() {
    final result = currencyResult.value;
    if (result.status == Status.notInitialized) return 'Ошибка...';
    if (result.isError) return 'Ошибка...';
    if (result.isLoading) return 'Загрузка...';
    final data = result.rates;
    if (data == null || data.isEmpty) return 'Нет данных';
    final date = data.first.date;
    return date.toDayMonthYearTextDateFormat() ?? 'Дата отсутствует';
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
