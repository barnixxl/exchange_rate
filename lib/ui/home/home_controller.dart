import 'package:mobx/mobx.dart';
import '../../models/rate_data.dart';
import '../../models/currency_result.dart';
import '../../services/currency_repository.dart';

class HomeController {
  HomeController(this._repository);

  final CurrencyRepository _repository;

  late final Observable<CurrencyResult<List<RateData>>> currencyResult =
      Observable(CurrencyLoading());

  List<RateData> get currencies => currencyResult.value.dataOrNull ?? [];

  late final Computed<String> lastUpdateDate = Computed(() {
    final result = currencyResult.value;
    if (result.isFailure) return 'Ошибка';
    if (result.isLoading) return 'Загрузка...';
    final data = result.dataOrNull;
    if (data == null || data.isEmpty) return 'Нет данных';
    final date = data.first.date;
    return '${date.day} ${_getMonthName(date.month)} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  });

  String _getMonthName(int month) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return months[month - 1];
  }

  Future<void> loadCurrencies() async {
    runInAction(() {
      currencyResult.value = CurrencyLoading();
    });

    final result = await _repository.fetchRates();
    runInAction(() {
      currencyResult.value = result;
    });
  }

  RateData? getCurrencyByCode(String code) {
    try {
      return currencies.firstWhere((c) => c.code == code);
    } catch (e) {
      return null;
    }
  }
}
