import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/main.dart';
import 'home_controller.dart';
import '../../app_router.dart';
import '../../utils/date_formatter.dart';

part 'error_state.part.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.home_title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade700,
            child: Observer(
              builder: (_) {
                _homeController.currencyResult.value;
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
          ),
        ),
        actions: [
          Observer(
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
                    : const Icon(
                        Icons.refresh,
                      ),
                onPressed: isLoading ? null : _loadData,
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Observer(
          builder: (_) {
            final result = _homeController.currencyResult.value;

            if (result.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(strings.loading_currencies),
                  ],
                ),
              );
            }

            if (result.isError) {
              return _buildErrorWidget(
                result.error?.toString(),
                () {
                  _loadData();
                },
              );
            }

            final currencies = result.data ?? [];

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        currency.code,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    title: Text(currency.name),
                    subtitle: Text(
                      strings.common_scale_equals_rate_byn(
                        currency.scale,
                        currency.code,
                        currency.rate.toStringAsFixed(4),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
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
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
