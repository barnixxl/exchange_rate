class CurrencyError {
  final int errorCode;
  final String message;

  const CurrencyError({required this.errorCode, required this.message});

  static const int unknowCode = -1;
  static const int timeoutCode = 1;
  static const int noInternetCode = 2;
  static const int serverCode = 3;
  static const int badResponseCode = 4;
  static const int cancelledCode = 5;
  static const int parsingCode = 6;
  static const int noDataCode = 7;
  static const int loadFailedCode = 8;

  @override
  String toString() => message;

  factory CurrencyError.fromException(Object e) {
    if (e is CurrencyError) return e;
    return CurrencyError(errorCode: unknowCode, message: e.toString());
  }

  factory CurrencyError.timeout() => const CurrencyError(
      errorCode: timeoutCode, message: 'Время соединения вышло');

  factory CurrencyError.noInternet() => const CurrencyError(
      errorCode: noInternetCode, message: 'Проверьте соединение с интернетом');

  factory CurrencyError.serverError(int statusCode) => CurrencyError(
      errorCode: serverCode, message: 'Ошибка сервера: $statusCode');

  factory CurrencyError.badResponse(int statusCode) => CurrencyError(
      errorCode: badResponseCode,
      message: 'Неверный ответ сервера: $statusCode');

  factory CurrencyError.cancelled() =>
      const CurrencyError(errorCode: cancelledCode, message: 'Запрос отменен');

  factory CurrencyError.unknown() => const CurrencyError(
      errorCode: unknowCode, message: 'Неизвестная ошибка сети');

  factory CurrencyError.parsing() => const CurrencyError(
      errorCode: parsingCode, message: 'Ошибка парсинга данных');

  factory CurrencyError.noData() => const CurrencyError(
      errorCode: noDataCode, message: 'Нет закэшированных данных');

  factory CurrencyError.loadFailed() => const CurrencyError(
      errorCode: loadFailedCode, message: 'Ошибка загрузки данных');
}
