part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<RateData> currencies,
  required void Function(
    RateData,
  ) onCurrencyPressed,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(
      8,
    ),
    itemCount: currencies.length,
    itemBuilder: (
      context,
      index,
    ) {
      final currency = currencies[index];
      return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            child: Text(
              currency.code,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          title: Text(
            currency.name,
          ),
          subtitle: Text(
            strings.common_scale_equals_rate_byn(
              currency.scale,
              currency.code,
              currency.rate.toStringAsFixed(
                2,
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            onCurrencyPressed(
              currency,
            );
          },
        ),
      );
    },
  );
}
