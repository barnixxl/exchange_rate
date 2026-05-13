import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_router.dart';
import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';
import 'converter_details_controller.dart';

part 'converter_details_screen.base_converter_input.part.dart';
part 'converter_details_screen.base_converter_result.part.dart';
part 'converter_details_screen.header.part.dart';
part 'converter_details_screen.info_row.part.dart';
part 'converter_details_screen.reverse_converter_input.part.dart';
part 'converter_details_screen.reverse_converter_result.part.dart';

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
    _controller = ConverterDetailsController()
      ..loadCurrency(
        _buildCurrencyModel(),
      );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final detailController = _controller;
    final exchangeRateText = strings.common_scale_equals_rate_byn(
      detailController.scale,
      detailController.code,
      detailController.rate.toStringAsFixed(4),
    );
    final formattedDate = detailController.date?.toDayMonthYearTextDateFormat();
    final String updatedDateText;
    if (formattedDate != null && formattedDate.isNotEmpty) {
      updatedDateText = formattedDate;
    } else {
      updatedDateText = strings.common_absent_date;
    }

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
                exchangeRateText: exchangeRateText,
                baseCurrencyName: widget.currency.baseCurrencyName,
                updatedDateText: updatedDateText,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBaseConverterInputWidget(
                    baseCurrencyCode: widget.currency.baseCurrencyCode,
                    onBaseAmountChanged: detailController.onBaseAmountChanged,
                  ),
                  Observer(
                    builder: (_) {
                      return Visibility(
                        visible: detailController.hasBaseAmount,
                        child: _buildBaseConverterResultWidget(
                          convertedResult: detailController.convertedAmount,
                          resultCurrencyName: detailController.name,
                          resultCurrencyCode: detailController.code,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReverseConverterInputWidget(
                    sourceCurrencyCode: detailController.code,
                    onCurrencyAmountChanged:
                        detailController.onCurrencyAmountChanged,
                  ),
                  Observer(
                    builder: (_) {
                      return Visibility(
                        visible: detailController.hasCurrencyAmount,
                        child: _buildReverseConverterResultWidget(
                          convertedResult:
                              detailController.convertedAmountReverse,
                          resultCurrencyName: widget.currency.baseCurrencyName,
                        ),
                      );
                    },
                  ),
                ],
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

  RateData _buildCurrencyModel() {
    return widget.currency.toRateData();
  }
}
