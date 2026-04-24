part of 'home_screen.dart';

extension _HomeScreenStateRoutingPart on _HomeScreenState {
  Widget _buildBody() {
    return Observer(
      builder: (_) {
        final result = _homeController.currencyResult.value;

        if (result.isLoading) {
          return _buildLoadingState();
        }

        if (result.isError) {
          return _buildErrorState(result.error);
        }

        return _buildSuccessState(result.data);
      },
    );
  }
}