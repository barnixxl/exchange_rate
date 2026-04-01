import 'package:currency_converter/models/currency_error.dart';

enum Status { loading, success, failure }

class CurrencyResult<T> {
  final T? data;
  final CurrencyError? error;
  final Status status;

  CurrencyResult()
      : data = null,
        error = null,
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

  R when<R>({
    required R Function(T data) success,
    required R Function(CurrencyError error) failure,
    required R Function() loading,
}) {
    switch (status) {
      case Status.success: return success(data as T);
      case Status.failure: return failure(error!);
      case Status.loading: return loading();
    }
  }
}
