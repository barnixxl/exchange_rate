part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required String Function(
    String,
  ) getImageForCode,
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
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(
                alpha: 0.3,
              ),
              blurRadius: 4,
              offset: const Offset(
                0,
                2,
              ),
            ),
          ],
        ),
        child: ListTile(
          textColor: AppColors.onPrimary,
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryLight,
            backgroundImage: AssetImage(
              getImageForCode(
                currency.code,
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
