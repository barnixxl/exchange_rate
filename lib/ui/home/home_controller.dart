import 'package:mobx/mobx.dart';
import '../../models/currency_model.dart';
import '../../services/currency_repository.dart';

class HomeController {
  HomeController(this._repository);

  final CurrencyRepository _repository;

  late final ObservableList<CurrencyModel> currencies =
      ObservableList<CurrencyModel>();
  late final Observable<bool> isLoading = Observable(false);
  late final Observable<String?> errorMessage = Observable<String?>(null);

  late final Computed<String> lastUpdateDate = Computed(() {
    if (currencies.isEmpty) return 'Нет данных';
    final date = currencies.first.date;
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
      errorMessage.value = null;
      isLoading.value = true;
    });

    try {
      final loadedCurrencies = await _repository.fetchRates();
      runInAction(() {
        currencies.clear();
        currencies.addAll(loadedCurrencies);
      });
    } catch (e) {
      runInAction(() {
        errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      });
      print('Ошибка загрузки: $e');
    } finally {
      runInAction(() {
        isLoading.value = false;
      });
    }
  }

  CurrencyModel? getCurrencyByCode(String code) {
    try {
      return currencies.firstWhere((c) => c.code == code);
    } catch (e) {
      return null;
    }
  }
}
