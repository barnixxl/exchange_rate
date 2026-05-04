import 'package:mobx/mobx.dart';

import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';

class DetailController {
  DetailController(this._currency);

  final RateData _currency;

  final Observable<String> baseAmountInput = Observable('');
  final Observable<String> currencyAmountInput = Observable('');

  String get code => _currency.code;

  String get name => _currency.name;

  double get rate => _currency.rate;

  int get scale => _currency.scale;

  DateTime? get date => _currency.date;

  String? get formattedDate => date.toDayMonthYearTextDateFormat();

  bool get hasBaseAmount => baseAmountInput.value.isNotEmpty;

  bool get hasCurrencyAmount => currencyAmountInput.value.isNotEmpty;

  String get convertedAmount {
    final amount = double.tryParse(
          baseAmountInput.value,
        ) ??
        0.0;
    return (amount * _currency.scale / _currency.rate).toStringAsFixed(2);
  }

  String get convertedAmountReverse {
    final amount = double.tryParse(
          currencyAmountInput.value,
        ) ??
        0.0;
    return (amount * _currency.rate / _currency.scale).toStringAsFixed(2);
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
}
