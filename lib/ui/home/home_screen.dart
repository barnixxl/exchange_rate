import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/main.dart';
import '../../models/rate_data.dart';
import 'home_controller.dart';
import '../../app_router.dart';
import 'home_app_bar.dart';
import 'loading_widget.dart';
import 'error_widget.dart';
import 'currencies_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _homeController = Provider.of<HomeController>(context, listen: false);
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  void _onCurrencyTap(RateData currency) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        currencyResult: _homeController.currencyResult,
        lastUpdateDate: _homeController.lastUpdateDate,
        onRefresh: _loadData,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Observer(
          builder: (_) {
            final result = _homeController.currencyResult.value;

            if (result.isLoading) {
              return const LoadingWidget();
            }

            if (result.isError) {
              return AppErrorWidget(
                errorMessage: result.error?.toString(),
                onRetry: _loadData,
              );
            }

            final currencies = result.data ?? [];

            return CurrenciesList(
              currencies: currencies,
              onItemTap: _onCurrencyTap,
            );
          },
        ),
      ),
    );
  }
}
