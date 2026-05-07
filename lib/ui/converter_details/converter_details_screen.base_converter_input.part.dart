part of 'converter_details_screen.dart';

Widget _buildBaseConverterInputWidget({
  required String baseCurrencyCode,
  required void Function(
    String,
  ) onBaseAmountChanged,
}) {
  return TextField(
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
  );
}
