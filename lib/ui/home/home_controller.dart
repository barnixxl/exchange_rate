import 'package:mobx/mobx.dart';

import '../../models/currency_result.dart';
import '../../models/currency_error.dart';
import '../../models/rate_data.dart';
import '../../repository/currency_repository.dart';
import '../../resources/images/app_images.dart';

class HomeController {
  final CurrencyRepository _repository = CurrencyRepository.getInstance();

  final Observable<CurrencyResult<List<RateData>>> _currencyResult = Observable(
    CurrencyResult.notInitialized(),
  );

  bool get isLoading => _currencyResult.value.isLoading;

  bool get hasError => _currencyResult.value.isError;

  bool get hasSuccess => _currencyResult.value.isSuccess;

  List<RateData> get currencies => _currencyResult.value.data ?? [];

  DateTime? get lastUpdateDate => currencies.firstOrNull?.date;

  CurrencyError? get error => _currencyResult.value.error;

  String imagesAssetsFor(String code) {
    switch (code) {
      case 'USD':
        return AppImages.usd.path;
      case 'EUR':
        return AppImages.eur.path;
      case 'CNY':
        return AppImages.cny.path;
      case 'PLN':
        return AppImages.pln.path;
      case 'UAH':
        return AppImages.uah.path;
      default:
        return AppImages.usd.path;
    }
  }

  Future<void> loadCurrencies() async {
    runInAction(() {
      _currencyResult.value = CurrencyResult.loading();
    });
    final result = await _repository.fetchRates();
    runInAction(() {
      _currencyResult.value = result;
    });
  }
}
