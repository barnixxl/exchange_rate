import 'package:flutter/material.dart';
import '../../app_router.dart';
import 'detail_controller.dart';
import '../../models/rate_data.dart';

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
  String _inputAmount = '';
  String _convertedAmount = '0';
  String _convertedAmountRevert = '0';

  @override
  void initState() {
    super.initState();
    final currencyModel = RateData(
      code: widget.currency.code,
      name: widget.currency.name,
      rate: widget.currency.rate,
      date: widget.currency.date,
      scale: widget.currency.scale,
    );
    controller = DetailController(currencyModel);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.code),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
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
                        '${controller.scale} ${controller.code} = ${controller.rate.toStringAsFixed(4)} BYN',
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        'Базовая валюта',
                        widget.currency.baseCurrencyName,
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
              const SizedBox(height: 24),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Сумма в ${widget.currency.baseCurrencyCode}',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _inputAmount = value;
                    final amount = double.tryParse(value) ?? 0.0;
                    _convertedAmount = controller.calculate(amount);
                  });
                },
              ),
              if (_inputAmount.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '$_convertedAmount ${widget.currency.name} (${widget.currency.code})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Сумма в ${widget.currency.code}',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _inputAmount = value;
                    final amount = double.tryParse(value) ?? 0.0;
                    _convertedAmountRevert =
                        controller.calculateReverse(amount);
                  });
                },
              ),
              if (_inputAmount.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '$_convertedAmountRevert ${widget.currency.baseCurrencyName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
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
