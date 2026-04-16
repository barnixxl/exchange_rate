// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_title => 'Конвертер валют';

  @override
  String get home_title => 'Курсы валют НБРБ';

  @override
  String updated_at(String date) {
    return 'Обновлено: $date';
  }

  @override
  String get loading_currencies => 'Загрузка курсов валют...';

  @override
  String get error => 'Ошибка...';

  @override
  String get retry => 'Повторить';

  @override
  String get base_currency_name => 'Белорусский рубль (BYN)';

  @override
  String get exchange_rate => 'Курс';

  @override
  String get base_cur_code => 'BYN';

  @override
  String get base_currency => 'Базовая валюта';

  @override
  String get update_date => 'Дата обновления';

  @override
  String get common_absent_date => 'Дата отсутствует';

  @override
  String amount_in(String currency) {
    return 'Сумма в $currency';
  }

  @override
  String common_scale_equals_rate_byn(int scale, String code, String rate) {
    return '$scale $code = $rate BYN';
  }

  @override
  String converted_result(
      String amount, String currencyName, String currencyCode) {
    return '$amount $currencyName ($currencyCode)';
  }

  @override
  String converted_result_reverse(String amount, String currencyName) {
    return '$amount $currencyName';
  }
}
