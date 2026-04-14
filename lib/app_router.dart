import 'package:flutter/material.dart';
import 'UI/home/home_screen.dart';
import 'UI/detail/detail_screen.dart';

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
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/detail':
        final currency = settings.arguments as CurrencyArgument;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(currency: currency),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
