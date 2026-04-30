import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_router.dart';
import '../../models/currency_error.dart';
import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';
import 'home_controller.dart';

part 'home_screen.error_state.part.dart';

part 'home_screen.app_bar_state.part.dart';

part 'home_screen.load_state.part.dart';

part 'home_screen.success_state.part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final homeController = _homeController;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          kToolbarHeight + 40,
        ),
        child: Observer(
          builder: (_) {
            return _buildAppBarWidget(
              lastUpdateDate: homeController.lastUpdateDate,
              isLoading: homeController.isLoading,
              onRetryPressed: _loadData,
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Stack(
          children: [
            Observer(
              builder: (_) {
                if (!homeController.isLoading) {
                  return const SizedBox.shrink();
                }
                return _buildLoadingWidget();
              },
            ),
            Observer(
              builder: (_) {
                if (!homeController.hasError) {
                  return const SizedBox.shrink();
                }
                final result = homeController.currencyResult.value;
                return _buildErrorWidget(
                  error: result.error,
                  onRetryPressed: _loadData,
                );
              },
            ),
            Observer(
              builder: (_) {
                if (!homeController.hasSuccess) {
                  return const SizedBox.shrink();
                }
                return _buildSuccessWidget(
                  currencies: homeController.currencies,
                  onCurrencyPressed: (currency) {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: CurrencyArgument(
                        code: currency.code,
                        name: currency.name,
                        rate: currency.rate,
                        date: currency.date,
                        scale: currency.scale,
                        baseCurrencyCode: strings.base_cur_code,
                        baseCurrencyName: strings.base_currency_name,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}