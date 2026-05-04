import '../main.dart';

class CurrencyError {
  final int errorCode;
  final String message;

  const CurrencyError({required this.errorCode, required this.message});

  static const int unknownCode = -1;
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
    return CurrencyError(
      errorCode: unknownCode,
      message: e.toString(),
    );
  }

  factory CurrencyError.timeout() => CurrencyError(
        errorCode: timeoutCode,
        message: strings.error_timeout,
      );

  factory CurrencyError.noInternet() => CurrencyError(
        errorCode: noInternetCode,
        message: strings.error_no_internet,
      );

  factory CurrencyError.serverError(int statusCode) => CurrencyError(
        errorCode: serverCode,
        message: strings.error_server(statusCode),
      );

  factory CurrencyError.badResponse(int statusCode) => CurrencyError(
        errorCode: badResponseCode,
        message: strings.error_bad_response(statusCode),
      );

  factory CurrencyError.cancelled() => CurrencyError(
        errorCode: cancelledCode,
        message: strings.error_cancelled,
      );

  factory CurrencyError.unknown() => CurrencyError(
        errorCode: unknownCode,
        message: strings.error_unknown,
      );

  factory CurrencyError.parsing() => CurrencyError(
        errorCode: parsingCode,
        message: strings.error_parsing,
      );

  factory CurrencyError.noData() => CurrencyError(
        errorCode: noDataCode,
        message: strings.error_no_data,
      );

  factory CurrencyError.loadFailed() => CurrencyError(
        errorCode: loadFailedCode,
        message: strings.error_load_failed,
      );
}
