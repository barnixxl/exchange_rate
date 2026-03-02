import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:auto_route/auto_route.dart';
import '../stores/currency_store.dart';
import '../services/currency_service.dart';
import 'detail_screen.dart'; // Импортируем для аргументов
import '../app_router.dart'; // Для навигации

// @RoutePage() - аннотация AutoRouter, помечает этот виджет как страницу
@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Создаем Store с зависимостью от CurrencyService
  late final CurrencyStore _currencyStore;

  @override
  void initState() {
    super.initState();

    // Инициализируем Store
    _currencyStore = CurrencyStore(CurrencyService());

    // Загружаем данные при старте
    _loadData();
  }

  // Метод для загрузки данных
  Future<void> _loadData() async {
    await _currencyStore.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar с заголовком и кнопкой обновления
      appBar: AppBar(
        title: const Text('Курсы валют'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // Нижняя часть AppBar с информацией о дате
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade700,
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.update, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    'Обновлено: ${_currencyStore.lastUpdateDate}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Кнопка обновления
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: _currencyStore.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.refresh),
              onPressed: _currencyStore.isLoading ? null : _loadData,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        // Pull-to-refresh
        onRefresh: _loadData,
        child: Observer(
          builder: (_) {
            // Показываем ошибку, если она есть
            if (_currencyStore.errorMessage != null) {
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
                        _currencyStore.errorMessage!,
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

            // Показываем загрузку
            if (_currencyStore.isLoading && _currencyStore.currencies.isEmpty) {
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

            // Показываем список валют
            if (_currencyStore.currencies.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _currencyStore.currencies.length,
                itemBuilder: (context, index) {
                  final currency = _currencyStore.currencies[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      // Левая часть - код валюты
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
                      // Название валюты
                      title: Text(currency.name),
                      // Курс с двумя знаками после запятой
                      subtitle: Text(
                        '1 ${_currencyStore.baseCurrency} = ${currency.rate.toStringAsFixed(2)} ${currency.code}',
                      ),
                      // Стрелочка справа
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      // По клику переходим на экран деталей
                      onTap: () {
                        // Используем AutoRouter для навигации
                        // Передаем аргументы через DetailRoute (сгенерировано)
                        context.pushRoute(
                          DetailRoute(
                            currency: CurrencyArgument(
                              code: currency.code,
                              name: currency.name,
                              rate: currency.rate,
                              date: currency.date,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            // Пустой экран (на всякий случай)
            return const Center(
              child: Text('Нет данных'),
            );
          },
        ),
      ),
    );
  }
}
