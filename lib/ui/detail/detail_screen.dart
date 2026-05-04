import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_router.dart';
import '../../models/rate_data.dart';
import 'detail_controller.dart';

part 'detail_screen.base_converter_state.part.dart';

part 'detail_screen.header_state.part.dart';

part 'detail_screen.info_row.part.dart';

part 'detail_screen.reverse_converter_state.part.dart';

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
  late final DetailController _controller;

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

    _controller = DetailController(
      currencyModel,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final detailController = _controller;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
              Observer(
                builder: (_) {
                  return _buildHeaderWidget(
                    code: detailController.code,
                    name: detailController.name,
                    exchangeRateText: strings.common_scale_equals_rate_byn(
                      detailController.scale,
                      detailController.code,
                      detailController.rate.toStringAsFixed(4),
                    ),
                    baseCurrencyName: widget.currency.baseCurrencyName,
                    updatedDateText: detailController.formattedDate ??
                        strings.common_absent_date,
                  );
                },
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
