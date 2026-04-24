part of 'home_screen.dart';

Widget _buildErrorBody(CurrencyResult result, VoidCallback onRetry) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            result.error?.toString() ?? strings.error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text(strings.retry)),
        ],
      ),
    ),
  );
}
