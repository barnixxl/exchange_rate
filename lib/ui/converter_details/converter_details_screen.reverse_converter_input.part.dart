part of 'converter_details_screen.dart';

Widget _buildReverseConverterInputWidget({
  required String sourceCurrencyCode,
  required void Function(
    String,
  ) onCurrencyAmountChanged,
}) {
  return TextField(
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
  );
}
