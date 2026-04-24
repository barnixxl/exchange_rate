part of 'home_screen.dart';

extension _HomeScreenAppBarPart on _HomeScreenState {
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(strings.home_title),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: _buildLastUpdatedBar(),
      ),
      actions: [_buildRefreshAction()],
    );
  }

  Widget _buildLastUpdatedBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue.shade700,
      child: Observer(
        builder: (_) {
          _homeController.currencyResult.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.update, size: 16, color: Colors.white70),
              const SizedBox(width: 4),
              Text(
                strings.updated_at(
                  _homeController.lastUpdateDate.value
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
    );
  }

  Widget _buildRefreshAction() {
    return Observer(
      builder: (_) {
        final isLoading = _homeController.currencyResult.value.isLoading;
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
              : const Icon(Icons.refresh),
          onPressed: isLoading ? null : _loadData,
        );
      },
    );
  }
}
