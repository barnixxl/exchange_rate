import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

part 'app_router.gr.dart';

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

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
      ];
}
