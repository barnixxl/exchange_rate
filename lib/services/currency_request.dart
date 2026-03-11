class FetchRatesRequest {
  final String baseCurrency;

  FetchRatesRequest({required this.baseCurrency});

  String get url => '/$baseCurrency';
}
