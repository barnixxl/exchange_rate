import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

class CurrencyArgument {
  final String code;
  final String name;
  final double rate;
  final DateTime date;

  CurrencyArgument({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
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
