import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

class CurrencyArgument{
  final String code;
  final String name;
  final double rate;
  final String date;

  CurrencyArgument({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
});
}

class $AppRouter {}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeScreen,
      initial: true,
    ),
    AutoRoute(
      page: DetailScreen,
    ),
  ],
)

class $AppRouter {}
