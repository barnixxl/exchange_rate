import 'package:mobx/mobx.dart';

import '../../main.dart';
import '../../models/currency_result.dart';
import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';

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
  String get convertedAmount => _calculateForward(
        _parseAmount(baseAmountInput.value),
      );
  String get convertedAmountReverse => _calculateReverse(
        _parseAmount(currencyAmountInput.value),
      );

  void onBaseAmountChanged(String value) {
    runInAction(() {
      baseAmountInput.value = value;
    });
  }

  void onCurrencyAmountChanged(String value) {
    runInAction(() {
      currencyAmountInput.value = value;
    });
  }

  void loadCurrency(RateData currency) {
    runInAction(() {
      _currencyResult.value = CurrencyResult.success(currency);
    });
  }

  double _parseAmount(String input) => double.tryParse(input) ?? 0.0;

  String _calculateForward(double amount) {
    final r = rate != 0 ? rate : 1;
    return (amount * scale / r).toStringAsFixed(2);
  }

  String _calculateReverse(double amount) {
    final s = scale != 0 ? scale : 1;
    return (amount * rate / s).toStringAsFixed(2);
  }
}
