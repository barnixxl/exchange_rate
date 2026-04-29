import 'package:mobx/mobx.dart';
import '../../models/rate_data.dart';
import '../../models/currency_result.dart';
import '../../services/currency_repository.dart';

class HomeController {
  final CurrencyRepository _repository = CurrencyRepository.getInstance();

  late final Observable<CurrencyResult<List<RateData>>> currencyResult =
      Observable(
    CurrencyResult.notInitialized(),
  );

  bool _extractIsLoading(CurrencyResult<List<RateData>> result) {
    return result.isLoading;
  }

  late final Computed<bool> isLoading = Computed(() {
    return _extractIsLoading(
      currencyResult.value,
    );
  });

  bool _extractHasError(CurrencyResult<List<RateData>> result) {
    return result.isError;
  }

  late final Computed<bool> hasError = Computed(() {
    return _extractHasError(
      currencyResult.value,
    );
  });

  bool _extractHasSuccess(CurrencyResult<List<RateData>> result) {
    return result.isSuccess;
  }

  late final Computed<bool> hasSuccess = Computed(() {
    return _extractHasSuccess(
      currencyResult.value,
    );
  });

  List<RateData> _extractCurrencies(
    CurrencyResult<List<RateData>> result,
  ) {
    if (result.isSuccess) {
      return result.data ?? [];
    }
    return [];
  }

  late final Computed<List<RateData>> currencies = Computed(() {
    return _extractCurrencies(
      currencyResult.value,
    );
  });

  DateTime? _extractLastUpdateDate(CurrencyResult<List<RateData>> result) {
    if (result.isError) return null;
    if (result.isLoading) return null;
    final data = result.data;
    if (data == null || data.isEmpty) return null;
    return data.first.date;
  }

  late final Computed<DateTime?> lastUpdateDate = Computed(() {
    return _extractLastUpdateDate(
      currencyResult.value,
    );
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
