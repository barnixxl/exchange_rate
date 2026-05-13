import 'package:flutter/material.dart';
import 'ui/home/home_screen.dart';
import 'ui/converter_details/converter_details_screen.dart';
import 'models/rate_data.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/converter_details':
        final currency = settings.arguments as RateData;
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
