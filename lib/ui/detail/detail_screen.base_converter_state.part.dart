part of 'detail_screen.dart';

Widget _buildBaseConverterWidget({
  required String baseCurrencyCode,
  required String resultCurrencyCode,
  required String resultCurrencyName,
  required bool hasResult,
  required String convertedResult,
  required void Function(
    String,
  ) onBaseAmountChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: InputDecoration(
          labelText: strings.amount_in(
            baseCurrencyCode,
          ),
          border: const OutlineInputBorder(),
        ),
        onChanged: onBaseAmountChanged,
      ),
      if (hasResult)
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            strings.converted_result(
              convertedResult,
              resultCurrencyName,
              resultCurrencyCode,
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
    ],
  );
}
