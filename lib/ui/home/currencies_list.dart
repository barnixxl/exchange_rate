import 'package:flutter/material.dart';
import '../../models/rate_data.dart';
import 'currency_list_item.dart';

class CurrenciesList extends StatelessWidget {
  final List<RateData> currencies;
  final void Function(RateData currency) onItemTap;

  const CurrenciesList({
    super.key,
    required this.currencies,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];
        return CurrencyListItem(
          currency: currency,
          onTap: () => onItemTap(currency),
        );
      },
    );
  }
}
