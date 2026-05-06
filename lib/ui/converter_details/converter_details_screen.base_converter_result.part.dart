part of 'converter_details_screen.dart';

Widget _buildBaseConverterResultWidget({
  required String convertedResult,
  required String resultCurrencyName,
  required String resultCurrencyCode,
}) {
  return Padding(
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
  );
}
