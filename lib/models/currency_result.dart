sealed class CurrencyResult<T> {
  const CurrencyResult();

  bool get isLoading => this is CurrencyLoading<T>;
  bool get isSuccess => this is CurrencySuccess<T>;
  bool get isFailure => this is CurrencyFailure<T>;

  T? get dataOrNull {
    if (this is CurrencySuccess<T>) {
      return (this as CurrencySuccess<T>).data;
    }
    return null;
  }

  String? get errorOrNull {
    if (this is CurrencyFailure<T>) {
      return (this as CurrencyFailure<T>).message;
    }
    return null;
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
    required R Function() loading,
  }) {
    if (this is CurrencySuccess<T>) {
      return success((this as CurrencySuccess<T>).data);
    } else if (this is CurrencyFailure<T>) {
      return failure((this as CurrencyFailure<T>).message);
    } else {
      return loading();
    }
  }

  @override
  String toString() => when(
        success: (data) => 'CurrencySuccess($data)',
        failure: (message) => 'CurrencyFailure($message)',
        loading: () => 'CurrencyLoading()',
      );
}

class CurrencySuccess<T> extends CurrencyResult<T> {
  final T data;
  const CurrencySuccess(this.data);
}

class CurrencyFailure<T> extends CurrencyResult<T> {
  final String message;
  const CurrencyFailure(this.message);
}

class CurrencyLoading<T> extends CurrencyResult<T> {
  const CurrencyLoading();
}
