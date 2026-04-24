part of 'home_screen.dart';

extension _HomeScreenCurrencyListPart on _HomeScreenState {
  Widget _buildCurrencyList(List<RateData> currencies) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];
        return _buildCurrencyTile(currency);
      },
    );
  }

  Widget _buildCurrencyTile(RateData currency) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(
            currency.code,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        title: Text(currency.name),
        subtitle: Text(
          strings.common_scale_equals_rate_byn(
            currency.scale,
            currency.code,
            currency.rate.toStringAsFixed(4),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _openCurrencyDetail(currency),
      ),
    );
  }

  void _openCurrencyDetail(RateData currency) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: CurrencyArgument(
        code: currency.code,
        name: currency.name,
        rate: currency.rate,
        date: currency.date,
        scale: currency.scale,
        baseCurrencyCode: strings.base_cur_code,
        baseCurrencyName: strings.base_currency_name,
      ),
    );
  }
}