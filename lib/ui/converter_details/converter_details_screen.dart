import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  final RateData currency;

  const ConverterDetailsScreen({
    super.key,
    required this.currency,
  });

  @override
  State<ConverterDetailsScreen> createState() => _ConverterDetailsScreenState();
}

class _ConverterDetailsScreenState extends State<ConverterDetailsScreen> {
  final ConverterDetailsController _controller = ConverterDetailsController();

  @override
  void initState() {
    super.initState();
    _controller.loadCurrency(
        widget.currency,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => FocusScope.of(
        context,
      ).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _controller.code,
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
                code: _controller.code,
                name: _controller.name,
                rate: _controller.rate,
                scale: _controller.scale,
                date: _controller.date,
                baseCurrencyName: strings.base_currency_name,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBaseConverterInputWidget(
                    baseCurrencyCode: strings.base_cur_code,
                    onBaseAmountChanged: _controller.onBaseAmountChanged,
                  ),
                  Observer(
                    builder: (_) {
                      return Visibility(
                        visible: _controller.hasBaseAmount,
                        child: _buildBaseConverterResultWidget(
                          convertedResult: _controller.convertedAmount,
                          resultCurrencyName: _controller.name,
                          resultCurrencyCode: _controller.code,
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
                    sourceCurrencyCode: _controller.code,
                    onCurrencyAmountChanged:
                        _controller.onCurrencyAmountChanged,
                  ),
                  Observer(
                    builder: (_) {
                      return Visibility(
                        visible: _controller.hasCurrencyAmount,
                        child: _buildReverseConverterResultWidget(
                          convertedResult:
                              _controller.convertedAmountReverse,
                          resultCurrencyName: strings.base_currency_name,
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
}
