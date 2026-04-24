part of 'home_screen.dart';

extension _HomeScreenLoadingStatePart on _HomeScreenState {
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(strings.loading_currencies),
        ],
      ),
    );
  }
}