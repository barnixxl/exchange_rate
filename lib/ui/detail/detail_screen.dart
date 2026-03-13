import 'package:flutter/material.dart';
import '../../app_router.dart';
import 'detail_controller.dart';
import '../../models/currency_model.dart';

class DetailScreen extends StatefulWidget {
  final CurrencyArgument currency;

  const DetailScreen({
    super.key,
    required this.currency,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final DetailController controller;

  @override
  void initState() {
    super.initState();
    final currencyModel = CurrencyModel(
      code: widget.currency.code,
      name: widget.currency.name,
      rate: widget.currency.rate,
      date: widget.currency.date,
    );
    controller = DetailController(currencyModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.code),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      controller.code,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      'Курс',
                      '${controller.rate.toStringAsFixed(4)} ${controller.code}',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Базовая валюта',
                      'Российский рубль (RUB)',
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      'Дата обновления',
                      '${controller.date.day} ${_getMonthName(controller.date.month)} ${controller.date.year}, ${controller.date.hour}:${controller.date.minute.toString().padLeft(2, '0')}',
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '100 RUB = ${(1 * controller.rate).toStringAsFixed(2)} ${controller.code}',
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
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
