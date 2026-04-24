part of 'home_screen.dart';

Widget _buildAppBarWidget(HomeController controller) {
  return AppBar(
    title: Text(
      strings.home_title,
    ),
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blue.shade700,
        child: Observer(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.update,
                  size: 16,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  strings.updated_at(
                    controller.lastUpdateDate.value
                            .toDayMonthYearTextDateFormat() ??
                        strings.common_absent_date,
                  ),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
    actions: [
      Observer(
        builder: (_) {
          final isLoading = controller.currencyResult.value.isLoading;
          return IconButton(
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.refresh,
                  ),
            onPressed: isLoading ? null : controller.loadCurrencies,
          );
        },
      ),
    ],
  );
}
