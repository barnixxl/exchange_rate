import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_router.dart';
import '../../models/rate_data.dart';
import 'converter_details_controller.dart';

part 'converter_details_screen.base_converter.part.dart';

part 'converter_details_screen.header.part.dart';

part 'converter_details_screen.info_row.part.dart';

part 'converter_details_screen.reverse_converter.part.dart';

class ConverterDetailsScreen extends StatefulWidget {
  final CurrencyArgument currency;

  const ConverterDetailsScreen({
    super.key,
    required this.currency,
  });

  @override
  State<ConverterDetailsScreen> createState() => _ConverterDetailsScreenState();
}

class _ConverterDetailsScreenState extends State<ConverterDetailsScreen> {
  late final ConverterDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConverterDetailsController(
      _buildCurrencyModel(),
    );
  }

  RateData _buildCurrencyModel() {
    return widget.currency.toRateData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final detailController = _controller;

    return GestureDetector(
      onTap: () => FocusScope.of(
        context,
      ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            detailController.code,
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderWidget(
                code: detailController.code,
                name: detailController.name,
                exchangeRateText: detailController.exchangeRateText,
                baseCurrencyName: widget.currency.baseCurrencyName,
                updatedDateText: detailController.updatedDateText,
              ),
              const SizedBox(
                height: 24,
              ),
              Observer(
                builder: (_) {
                  return _buildBaseConverterWidget(
                    baseCurrencyCode: widget.currency.baseCurrencyCode,
                    resultCurrencyCode: detailController.code,
                    resultCurrencyName: detailController.name,
                    hasResult: detailController.hasBaseAmount,
                    convertedResult: detailController.convertedAmount,
                    onBaseAmountChanged: detailController.onBaseAmountChanged,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Observer(
                builder: (_) {
                  return _buildReverseConverterWidget(
                    sourceCurrencyCode: detailController.code,
                    resultCurrencyName: widget.currency.baseCurrencyName,
                    hasResult: detailController.hasCurrencyAmount,
                    convertedResult: detailController.convertedAmountReverse,
                    onCurrencyAmountChanged:
                        detailController.onCurrencyAmountChanged,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
