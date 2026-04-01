enum Status { loading, success, failure }

class CurrencyResult<T> {
  final T? data;
  final String? error;
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
  bool get isSuccess => status == Status.success;
  bool get isFailure => status == Status.failure;

  T? get dataOrNull => isSuccess ? data : null;
  String? get errorOrNull => isFailure ? error : null;

  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  required R Function() loading,
}) {
    switch (status) {
      case Status.success: return success(data as T);
      case Status.failure: return failure(error!);
      case Status.loading: return loading();
    }
  }
}
