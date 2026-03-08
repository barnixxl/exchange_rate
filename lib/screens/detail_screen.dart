import 'package:flutter/material.dart';
import '../app_router.dart';

class DetailScreen extends StatelessWidget {
  // Получаем аргументы через конструктор
  // Это типобезопасно! Компилятор проверит, что передается правильный тип
  final CurrencyArgument currency;

  const DetailScreen({
    super.key,
    required this.currency, // required - обязательный параметр
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currency.code), // Код валюты в заголовке
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Карточка с основной информацией
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Крупный код валюты
                    Text(
                      currency.code,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Название
                    Text(
                      currency.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(height: 32),

                    // Информация о курсе
                    _buildInfoRow(
                      'Курс',
                      '${currency.rate.toStringAsFixed(4)} ${currency.code}',
                    ),
                    const SizedBox(height: 16),

                    _buildInfoRow(
                      'Базовая валюта',
                      'Российский рубль (RUB)',
                    ),
                    const SizedBox(height: 16),

                    _buildInfoRow(
                      'Дата обновления',
                      '${currency.date.day} ${_getMonthName(currency.date.month)} ${currency.date.year}, ${currency.date.hour}:${currency.date.minute.toString().padLeft(2, '0')}',
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Кнопка "Рассчитать"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Показываем SnackBar с примером расчета
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '100 RUB = ${(100 * currency.rate).toStringAsFixed(2)} ${currency.code}',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Рассчитать 100 RUB'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный виджет для отображения строки информации
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return months[month - 1];
  }
}
