part of 'converter_details_screen.dart';

Widget _buildReverseConverterResultWidget({
  required String convertedResult,
  required String resultCurrencyName,
}) {
  return Padding(
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
  );
}
