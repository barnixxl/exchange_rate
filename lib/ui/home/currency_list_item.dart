import 'package:flutter/material.dart';
import 'package:currency_converter/main.dart';
import '../../models/rate_data.dart';

class CurrencyListItem extends StatelessWidget {
  final RateData currency;
  final VoidCallback onTap;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
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
        onTap: onTap,
      ),
    );
  }
}
