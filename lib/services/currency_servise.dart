import 'package:dio/dio.dart';
import '../models/currency_model.dart';

class CurrencyService {
  late final Dio _dio;  // использую dio для отправки http запросов


CurrencyService() {
  _dio = Dio(BaseOptions(
    baseUrl: 'https://api.exchangerate-api.com/v4/latest/', // Базовый URL
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  _dio.interceptors.add(LogInterceptor( // интерцептор для отладки
    request: true,
    requestBody: true,
    responseBody: true,
    error: true,
  ));
}

  // метод для получения курсов валют
  // baseCurrency - базовая валюта, относительно которой считаем курсы
  // Future означает, что результат будет получен асинхронно
  Future<List<CurrencyModel>> fetchRates(String baseCurrency) async {
    try {
      // Делаем GET запрос к API
      final response = await _dio.get('/$baseCurrency');

      // Проверяем статус ответа
      if (response.statusCode == 200) {
        // response.data - это Map<String, dynamic>
        final data = response.data as Map<String, dynamic>;

        // Извлекаем дату обновления
        final date = DateTime.parse(data['date'] ?? DateTime.now().toIso8601String());

        // Извлекаем курсы валют
        final rates = data['rates'] as Map<String, dynamic>;

        final Currencies = ['USD', 'EUR', 'GBP', 'CNY', 'JPY'];

        // Преобразуем Map в список моделей CurrencyModel
        final currencies = <CurrencyModel>[];

        // просматриваем все курсы
        rates.forEach((code, rate) {
          if (Currencies.contains(code)) {
            currencies.add(CurrencyModel(
              code: code,
              name: _getCurrencyName(code), // получаем название
              rate: rate.toDouble(),
              date: date,
            ));
          }
        });

        // сортировка по коду валюты для структуры
        currencies.sort((a, b) => a.code.compareTo(b.code));

        return currencies;
      } else {
        // Если статус не 200, выбрасываем исключение
        throw Exception('ошибка при загрузке: ${response.statusCode}');
      }
    } on DioException catch (e) { // обработка ошибки на интернет или отсутствие ответа
      throw Exception('ошибка. проверьте статус сети: ${e.message}');
    }
  }

  String _getCurrencyName(String code) { // получаем выбранную валюту
    const names = {
      'USD': 'Доллар США',
      'EUR': 'Евро',
      'GBP': 'Фунт стерлингов',
      'JPY': 'Японская иена',
      'CNY': 'Китайский юань',
    };

    return names[code] ?? code;  // при отсутствии возвращаем код
  }
}