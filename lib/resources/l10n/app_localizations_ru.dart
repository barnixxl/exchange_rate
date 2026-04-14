// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Конвертер валют';

  @override
  String get homeTitle => 'Курсы валют НБРБ';

  @override
  String updatedAt(String date) {
    return 'Обновлено: $date';
  }

  @override
  String get loadingCurrencies => 'Загрузка курсов валют...';

  @override
  String get error => 'Ошибка...';

  @override
  String get retry => 'Повторить';

  @override
  String get baseCurrencyName => 'Белорусский рубль (BYN)';

  @override
  String get exchangeRate => 'Курс';

  @override
  String get baseCurCode => 'BYN';

  @override
  String get baseCurrency => 'Базовая валюта';

  @override
  String get updateDate => 'Дата обновления';

  @override
  String get absentDate => 'Дата отсутствует';

  @override
  String amountIn(String currency) {
    return 'Сумма в $currency';
  }

  @override
  String scaleEqualsRateByn(int scale, String code, String rate) {
    return '$scale $code = $rate BYN';
  }

  @override
  String convertedResult(
      String amount, String currencyName, String currencyCode) {
    return '$amount $currencyName ($currencyCode)';
  }

  @override
  String convertedResultReverse(String amount, String currencyName) {
    return '$amount $currencyName';
  }
}
