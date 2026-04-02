import 'package:currency_converter/models/currency_error.dart';

enum Status { loading, success, failure }

class CurrencyResult<T> {
  final T? data;
  final CurrencyError? error;
  final Status status;

  CurrencyResult.loading({this.data})
      : error = null,
        status = Status.loading;

  CurrencyResult.success(this.data)
      : error = null,
        status = Status.success;

  CurrencyResult.failure(this.error)
      : data = null,
        status = Status.failure;

  bool get isLoading => status == Status.loading;

  bool get isError => status == Status.failure;

  bool get isSuccess => status == Status.success;

  T? get dataOrNull => isSuccess ? data : null;

  CurrencyError? get errorOrNull => isError ? error : null;
}
