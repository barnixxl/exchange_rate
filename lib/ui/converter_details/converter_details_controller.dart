import 'package:mobx/mobx.dart';
import 'package:currency_converter/main.dart';

import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';

class ConverterDetailsController {
  ConverterDetailsController(RateData currency) : _currency = currency;

  final RateData _currency;

  final Observable<String> baseAmountInput = Observable(
    '',
  );

  final Observable<String> currencyAmountInput = Observable(
    '',
  );

  String get code => _currency.code;

  String get name => _currency.name;

  double get rate => _currency.rate;

  int get scale => _currency.scale;

  DateTime? get date => _currency.date;

  String? get formattedDate => date.toDayMonthYearTextDateFormat();

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
      baseAmountInput.value = value;
    });
  }

  void onCurrencyAmountChanged(
    String value,
  ) {
    runInAction(() {
      currencyAmountInput.value = value;
    });
  }

  double _parseAmount(
    String input,
  ) =>
      double.tryParse(
        input,
      ) ??
      0.0;

  String _calculateForward(
    double amount,
  ) {
    return (amount * _currency.scale / _currency.rate).toStringAsFixed(2);
  }

  String _calculateReverse(
    double amount,
  ) {
    return (amount * _currency.rate / _currency.scale).toStringAsFixed(2);
  }
}
