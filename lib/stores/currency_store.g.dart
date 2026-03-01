// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrencyStore on _CurrencyStore, Store {
  Computed<String>? _$lastUpdateDateComputed;

  @override
  String get lastUpdateDate =>
      (_$lastUpdateDateComputed ??= Computed<String>(() => super.lastUpdateDate,
              name: '_CurrencyStore.lastUpdateDate'))
          .value;

  late final _$currenciesAtom =
      Atom(name: '_CurrencyStore.currencies', context: context);

  @override
  ObservableList<CurrencyModel> get currencies {
    _$currenciesAtom.reportRead();
    return super.currencies;
  }

  @override
  set currencies(ObservableList<CurrencyModel> value) {
    _$currenciesAtom.reportWrite(value, super.currencies, () {
      super.currencies = value;
    });
  }

  late final _$baseCurrencyAtom =
      Atom(name: '_CurrencyStore.baseCurrency', context: context);

  @override
  String get baseCurrency {
    _$baseCurrencyAtom.reportRead();
    return super.baseCurrency;
  }

  @override
  set baseCurrency(String value) {
    _$baseCurrencyAtom.reportWrite(value, super.baseCurrency, () {
      super.baseCurrency = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_CurrencyStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CurrencyStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loadCurrenciesAsyncAction =
      AsyncAction('_CurrencyStore.loadCurrencies', context: context);

  @override
  Future<void> loadCurrencies() {
    return _$loadCurrenciesAsyncAction.run(() => super.loadCurrencies());
  }

  late final _$changeBaseCurrencyAsyncAction =
      AsyncAction('_CurrencyStore.changeBaseCurrency', context: context);

  @override
  Future<void> changeBaseCurrency(String newCurrency) {
    return _$changeBaseCurrencyAsyncAction
        .run(() => super.changeBaseCurrency(newCurrency));
  }

  late final _$_CurrencyStoreActionController =
      ActionController(name: '_CurrencyStore', context: context);

  @override
  CurrencyModel? getCurrencyByCode(String code) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.getCurrencyByCode');
    try {
      return super.getCurrencyByCode(code);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currencies: ${currencies},
baseCurrency: ${baseCurrency},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
lastUpdateDate: ${lastUpdateDate}
    ''';
  }
}
