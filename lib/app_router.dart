import 'package:flutter/material.dart';
import 'ui/home/home_screen.dart';
import 'ui/converter_details/converter_details_screen.dart';
import 'models/rate_data.dart';

class CurrencyArgument {
  final String code;
  final String name;
  final double rate;
  final DateTime? date;
  final int scale;
  final String baseCurrencyCode;
  final String baseCurrencyName;

  CurrencyArgument({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
    required this.scale,
    required this.baseCurrencyCode,
    required this.baseCurrencyName,
  });

  RateData toRateData() {
    return RateData(
      code: code,
      name: name,
      rate: rate,
      date: date,
      scale: scale,
    );
  }
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/converter_details':
        final currency = settings.arguments as CurrencyArgument;
        return MaterialPageRoute(
          builder: (_) => ConverterDetailsScreen(currency: currency),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
