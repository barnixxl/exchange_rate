import 'package:currency_converter/models/currency_result.dart';
import 'package:mobx/mobx.dart';

import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';
import '../../main.dart';

class ConverterDetailsController {
  final Observable<CurrencyResult<RateData>> _currencyResult = Observable(
    CurrencyResult.notInitialized(),
  );

  final Observable<String> baseAmountInput = Observable('');
  final Observable<String> currencyAmountInput = Observable('');

  String get code => _currencyResult.value.data?.code ?? '';

  String get name => _currencyResult.value.data?.name ?? '';

  double get rate => _currencyResult.value.data?.rate ?? 0.0;

  int get scale => _currencyResult.value.data?.scale ?? 1;

  DateTime? get date => _currencyResult.value.data?.date;

  String? get formattedDate => date?.toDayMonthYearTextDateFormat();

  String get exchangeRateText => strings.common_scale_equals_rate_byn(
        scale,
        code,
        rate.toStringAsFixed(4),
      );

  String get updatedDateText => formattedDate ?? strings.common_absent_date;

  bool get hasBaseAmount => baseAmountInput.value.isNotEmpty;

  bool get hasCurrencyAmount => currencyAmountInput.value.isNotEmpty;

  String get convertedAmount {
    final amount = _parseAmount(
      baseAmountInput.value,
    );
    return _calculateForward(
      amount,
    );
  }

  String get convertedAmountReverse {
    final amount = _parseAmount(
      currencyAmountInput.value,
    );
    return _calculateReverse(
      amount,
    );
  }

  void onBaseAmountChanged(
    String value,
  ) {
    runInAction(() {
      _onBaseAmountChanged(
        value,
      );
    });
  }

  void onCurrencyAmountChanged(
    String value,
  ) {
    runInAction(() {
      _onCurrencyAmountChanged(
        value,
      );
    });
  }

  void loadCurrency(
    RateData currency,
  ) {
    runInAction(() {
      _loadCurrency(
        currency,
      );
    });
  }

  void _onBaseAmountChanged(
    String value,
  ) {
    baseAmountInput.value = value;
  }

  void _onCurrencyAmountChanged(
    String value,
  ) {
    currencyAmountInput.value = value;
  }

  void _loadCurrency(
    RateData currency,
  ) {
    _currencyResult.value = CurrencyResult.success(currency);
  }

  double _parseAmount(
    String input,
  ) =>
      double.tryParse(input) ?? 0.0;

  String _calculateForward(
    double amount,
  ) {
    final r = rate != 0 ? rate : 1;
    return (amount * scale / r).toStringAsFixed(2);
  }

  String _calculateReverse(
    double amount,
  ) {
    final s = scale != 0 ? scale : 1;
    return (amount * rate / s).toStringAsFixed(2);
  }
}
