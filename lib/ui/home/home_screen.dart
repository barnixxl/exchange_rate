import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'home_controller.dart';
import '../../services/currency_repository.dart';
import '../../network/currency_rate_network.dart';
import '../../network/currency/currency_api.dart';
import '../../app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();

    _homeController =
        HomeController(CurrencyRepository(CurrencyApi(CurrencyRateNetwork())));

    _loadData();
  }

  Future<void> _loadData() async {
    await _homeController.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Курсы валют НБРБ'),
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
                    const Icon(Icons.update, size: 16, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      'Обновлено: ${_homeController.lastUpdateDate.value}',
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
                    : const Icon(Icons.refresh),
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
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Загрузка курсов валют...'),
                  ],
                ),
              );
            }

            if (result.isError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        result.errorOrNull.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final currencies = result.dataOrNull ?? [];

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
                      '1 ${currency.code} = ${currency.rate.toStringAsFixed(4)} BYN',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: CurrencyArgument(
                          code: currency.code,
                          name: currency.name,
                          rate: currency.rate,
                          date: currency.date,
                          baseCurrencyCode: 'BYN',
                          baseCurrencyName: 'Белорусский рубль (BYN)',
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
