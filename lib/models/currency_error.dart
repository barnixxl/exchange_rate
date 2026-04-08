class CurrencyError {
  final String code;
  final String message;

  const CurrencyError({required this.code, required this.message});

  @override
  String toString() => message;

  factory CurrencyError.fromException(Object e) {
    if (e is CurrencyError) return e;
    return CurrencyError(code: 'UNKNOWN', message: e.toString());
  }

  factory CurrencyError.timeout() =>
      const CurrencyError(code: 'TIMEOUT', message: 'Время соединения вышло');

  factory CurrencyError.noInternet() => const CurrencyError(
      code: 'NO_INTERNET', message: 'Проверьте соединение с интернетом');

  factory CurrencyError.serverError(int statusCode) => CurrencyError(
      code: 'SERVER: $statusCode', message: 'Ошибка сервера: $statusCode');

  factory CurrencyError.badResponse(int statusCode) => CurrencyError(
      code: 'BAD_RESPONSE: $statusCode',
      message: 'Неверный ответ сервера: $statusCode');

  factory CurrencyError.cancelled() =>
      const CurrencyError(code: 'CANCELLED', message: 'Запрос отменен');

  factory CurrencyError.unknown() =>
      const CurrencyError(code: 'UNKNOWN', message: 'Неизвестная ошибка сети');

  factory CurrencyError.parsing() =>
      const CurrencyError(code: 'PARSING', message: 'Ошибка парсинга данных');

  factory CurrencyError.noData() => const CurrencyError(
      code: 'NO_DATA', message: 'Нет закэшированных данных');

  factory CurrencyError.loadFailed() => const CurrencyError(
      code: 'LOAD_FAILED', message: 'Ошибка загрузки данных');
}
