import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:currency_converter/main.dart';
import '../../models/currency_result.dart';
import '../../models/rate_data.dart';
import '../../utils/date_formatter.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Observable<CurrencyResult<List<RateData>>> currencyResult;
  final Computed<DateTime?> lastUpdateDate;
  final VoidCallback onRefresh;

  const HomeAppBar({
    super.key,
    required this.currencyResult,
    required this.lastUpdateDate,
    required this.onRefresh,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              currencyResult.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.update, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    strings.updated_at(
                      lastUpdateDate.value?.toDayMonthYearTextDateFormat() ??
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
            final isLoading = currencyResult.value.isLoading;
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
              onPressed: isLoading ? null : onRefresh,
            );
          },
        ),
      ],
    );
  }
}
