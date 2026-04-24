part of 'home_screen.dart';

extension _HomeScreenSuccessStatePart on _HomeScreenState {
  Widget _buildSuccessState(List<RateData>? data) {
    final currencies = data ?? <RateData>[];
    return _buildCurrencyList(currencies);
  }
}