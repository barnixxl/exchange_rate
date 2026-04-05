import 'package:currency_converter/models/currency_error.dart';

enum Status { notInitialized, loading, success, failure }

class CurrencyResult<T> {
  final T? rates;
  final CurrencyError? error;
  final Status status;

  CurrencyResult.notInitialized()
      : rates = null,
        error = null,
        status = Status.notInitialized;

  CurrencyResult.loading({this.rates})
      : error = null,
        status = Status.loading;

  CurrencyResult.success(this.rates)
      : error = null,
        status = Status.success;

  CurrencyResult.failure(this.error)
      : rates = null,
        status = Status.failure;

  bool get isLoading => status == Status.loading;

  bool get isError => status == Status.failure;
}
