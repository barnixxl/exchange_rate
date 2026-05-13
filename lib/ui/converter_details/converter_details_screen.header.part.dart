part of 'converter_details_screen.dart';

Widget _buildHeaderWidget({
  required String code,
  required String name,
  required double rate,
  required int scale,
  required DateTime? date,
  required String baseCurrencyName,
}) {
  final exchangeRateText = strings.common_scale_equals_rate_byn(
    scale,
    code,
    rate.toStringAsFixed(4),
  );
  final formattedDate = date?.toDayMonthYearTextDateFormat() ?? '';
  final hasValidDate = formattedDate.isNotEmpty;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                code,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const Divider(
                height: 32,
              ),
              _buildInfoRow(
                label: strings.exchange_rate,
                value: exchangeRateText,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInfoRow(
                label: strings.base_currency,
                value: baseCurrencyName,
              ),
              const SizedBox(
                height: 16,
              ),
              _buildInfoRow(
                label: strings.update_date,
                value: hasValidDate ? formattedDate : strings.common_absent_date,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 24,
      ),
    ],
  );
}
