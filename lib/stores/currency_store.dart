import 'package:mobx/mobx.dart';
import '../models/currency_model.dart';
import '../services/currency_service.dart';
part 'currency_store.g.dart';

// Класс, который будет использоваться в UI
class CurrencyStore = _CurrencyStore with _$CurrencyStore;

// Абстрактный класс с логикой
abstract class _CurrencyStore with Store {
  // Сервис для работы с API (инъекция через конструктор)
  final CurrencyService _currencyService;

  // Конструктор
  _CurrencyStore(this._currencyService);

  // --- Observable состояния (наблюдаемые переменные) ---

  @observable
  // Список валют
  ObservableList<CurrencyModel> currencies = ObservableList<CurrencyModel>();

  @observable
  // Базовая валюта (по умолчанию RUB - российский рубль)
  String baseCurrency = 'RUB';

  @observable
  // Флаг загрузки
  bool isLoading = false;

  @observable
  // Сообщение об ошибке (если есть)
  String? errorMessage;

  @computed
  // Получаем дату последнего обновления (если есть валюты)
  String get lastUpdateDate {
    if (currencies.isEmpty) return 'Нет данных';

    // Берем дату из первой валюты (у всех она одинаковая)
    final date = currencies.first.date;

    // Форматируем дату: "15 марта 2024, 14:30"
    return '${date.day} ${_getMonthName(date.month)} ${date.year}, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  // Вспомогательный метод для получения названия месяца
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

  // --- Actions (действия) ---

  @action
  // Загрузка курсов валют
  Future<void> loadCurrencies() async {
    // Сбрасываем предыдущую ошибку
    errorMessage = null;

    // Включаем индикатор загрузки
    isLoading = true;

    try {
      // Получаем данные от сервиса
      final loadedCurrencies = await _currencyService.fetchRates(baseCurrency);

      // Очищаем старый список и добавляем новый
      currencies.clear();
      currencies.addAll(loadedCurrencies);
    } catch (e) {
      // Если ошибка - сохраняем сообщение
      errorMessage = e.toString().replaceFirst('Exception: ', '');

      // Для отладки выводим в консоль
      print('Ошибка загрузки: $e');
    } finally {
      // В любом случае выключаем индикатор загрузки
      isLoading = false;
    }
  }

  @action
  // Смена базовой валюты
  Future<void> changeBaseCurrency(String newCurrency) async {
    // Если валюта не изменилась - ничего не делаем
    if (baseCurrency == newCurrency) return;

    // Меняем базовую валюту
    baseCurrency = newCurrency;

    // Загружаем новые курсы
    await loadCurrencies();
  }

  @action
  // Получить валюту по коду (для экрана деталей)
  CurrencyModel? getCurrencyByCode(String code) {
    try {
      // Ищем валюту в списке
      return currencies.firstWhere((c) => c.code == code);
    } catch (e) {
      // Если не найдена - возвращаем null
      return null;
    }
  }
}
