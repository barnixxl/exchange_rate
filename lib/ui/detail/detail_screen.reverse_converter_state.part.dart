part of 'detail_screen.dart';

Widget _buildReverseConverterWidget({
  required String sourceCurrencyCode,
  required String resultCurrencyName,
  required bool hasResult,
  required String convertedResult,
  required void Function(
    String,
  ) onCurrencyAmountChanged,
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
            sourceCurrencyCode,
          ),
          border: const OutlineInputBorder(),
        ),
        onChanged: onCurrencyAmountChanged,
      ),
      if (hasResult)
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            strings.converted_result_reverse(
              convertedResult,
              resultCurrencyName,
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
